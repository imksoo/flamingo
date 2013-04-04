#
# Cookbook Name:: mysql-server-5.6
# Recipe:: default
#
# Copyright 2013, Kiniro Minato / @imksoo
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#     http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
#

chef_tempdir = "/tmp/chef/mysql"

mysql_packages =  [
	"MySQL-client-5.6.10-1.el6.x86_64.rpm",
	"MySQL-devel-5.6.10-1.el6.x86_64.rpm",
	"MySQL-server-5.6.10-1.el6.x86_64.rpm",
	"MySQL-shared-5.6.10-1.el6.x86_64.rpm",
	"MySQL-shared-compat-5.6.10-1.el6.x86_64.rpm",
	"MySQL-test-5.6.10-1.el6.x86_64.rpm"
]

directory "#{chef_tempdir}"

mysql_packages.each { |pkg|
	cookbook_file "#{chef_tempdir}/#{pkg}" do
		not_if "rpm -q MySQL-server"
	end
}

mysql_package_source = []
mysql_packages.each { |pkg| mysql_package_source.push("#{chef_tempdir}/#{pkg}") }

execute "install-mysql-server-5.6" do
	command "yum install -y #{mysql_package_source.join(' ')}"
	notifies :start, "service[mysql]", :immediately
	notifies :run, "execute[mysql-set-root-password]", :immediately
	notifies :run, "script[mysql-secure-installation]", :immediately
	not_if "rpm -q MySQL-server"
end

service "mysql" do
	action [:enable, :start]
end

execute "mysql-set-root-password" do 
	action :nothing
	command "mysqladmin -uroot -p`cat /root/.mysql_secret | grep password | sed 's/.*://g' | awk '{print $1}'` password '#{node.mysql_server.default_root_password}'"
end

mysql_cmd = "mysql -uroot -p#{node.mysql_server.default_root_password}"
script "mysql-secure-installation" do
	action :nothing
	interpreter "bash"
	code <<-EOH
		echo "DELETE FROM mysql.user WHERE User='root' AND Host NOT IN ('#{node.fqdn}', '#{node.hostname}', 'localhost', '127.0.0.1', '::1');" | #{mysql_cmd}
		echo "DROP DATABASE test;" | #{mysql_cmd}
		echo "DELETE FROM mysql.db WHERE Db='test' OR Db='test\\_%';" | #{mysql_cmd}
		echo "FLUSH PRIVILEGES;" | #{mysql_cmd}
	EOH
end

template "/etc/zabbix/zabbix_agentd.d/userparameter_mysql.conf" do
	mode "644"
	owner "root"
	group "root"
	source "userparameter_mysql.conf.erb"
end

template "/etc/zabbix/zabbix-agentd-my.cnf" do
	mode "640"
	owner "root"
	group "zabbix"
	source "zabbix-agentd-my.cnf.erb"
end
