#
# Cookbook Name:: zabbix-server-sia
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

chef_tempdir = "/tmp/chef/zabbix"

zabbix_packages =  [
	"OpenIPMI-libs-2.0.16-14.el6.x86_64.rpm",
	"apr-1.3.9-5.el6_2.x86_64.rpm",
	"apr-util-1.3.9-3.el6_0.1.x86_64.rpm",
	"apr-util-ldap-1.3.9-3.el6_0.1.x86_64.rpm",
	"dejavu-fonts-common-2.30-2.el6.noarch.rpm",
	"dejavu-sans-fonts-2.30-2.el6.noarch.rpm",
	"fontpackages-filesystem-1.41-1.1.el6.noarch.rpm",
	"fping-2.4b2-10.el6.x86_64.rpm",
	"freetype-2.3.11-14.el6_3.1.x86_64.rpm",
	"gnutls-2.8.5-10.el6_4.1.x86_64.rpm",
	"httpd-2.2.15-26.el6.centos.x86_64.rpm",
	"httpd-tools-2.2.15-26.el6.centos.x86_64.rpm",
	"iksemel-1.4-2.el6.x86_64.rpm",
	"libX11-1.5.0-4.el6.x86_64.rpm",
	"libX11-common-1.5.0-4.el6.noarch.rpm",
	"libXau-1.0.6-4.el6.x86_64.rpm",
	"libXpm-3.5.10-2.el6.x86_64.rpm",
	"libjpeg-turbo-1.2.1-1.el6.x86_64.rpm",
	"libpng-1.2.49-1.el6_2.x86_64.rpm",
	"libtasn1-2.3-3.el6_2.1.x86_64.rpm",
	"libtool-ltdl-2.2.6-15.5.el6.x86_64.rpm",
	"libxcb-1.8.1-1.el6.x86_64.rpm",
	"libxslt-1.1.26-2.el6_3.1.x86_64.rpm",
	"lm_sensors-libs-3.1.1-17.el6.x86_64.rpm",
	"mailcap-2.1.31-2.el6.noarch.rpm",
	"net-snmp-5.5-44.el6.x86_64.rpm",
	"net-snmp-libs-5.5-44.el6.x86_64.rpm",
	"php-5.3.3-22.el6.x86_64.rpm",
	"php-bcmath-5.3.3-22.el6.x86_64.rpm",
	"php-cli-5.3.3-22.el6.x86_64.rpm",
	"php-common-5.3.3-22.el6.x86_64.rpm",
	"php-gd-5.3.3-22.el6.x86_64.rpm",
	"php-mbstring-5.3.3-22.el6.x86_64.rpm",
	"php-mysql-5.3.3-22.el6.x86_64.rpm",
	"php-pdo-5.3.3-22.el6.x86_64.rpm",
	"php-xml-5.3.3-22.el6.x86_64.rpm",
	"traceroute-2.0.14-2.el6.x86_64.rpm",
	"unixODBC-2.2.14-12.el6_3.x86_64.rpm",
	"vlgothic-fonts-common-20091202-2.el6.noarch.rpm",
	"vlgothic-p-fonts-20091202-2.el6.noarch.rpm",
#	"zabbix-2.0.5-1.el6.x86_64.rpm",
#	"zabbix-agent-2.0.5-1.el6.x86_64.rpm",
#	"zabbix-get-2.0.5-1.el6.x86_64.rpm",
#	"zabbix-sender-2.0.5-1.el6.x86_64.rpm",
#	"zabbix-server-2.0.5-1.el6.x86_64.rpm",
#	"zabbix-server-mysql-2.0.5-1.el6.x86_64.rpm",
#	"zabbix-web-2.0.5-1.el6.noarch.rpm",
#	"zabbix-web-japanese-2.0.5-1.el6.noarch.rpm",
#	"zabbix-web-mysql-2.0.5-1.el6.noarch.rpm"
	"zabbix-2.0.6-1.el6.x86_64.rpm",
	"zabbix-agent-2.0.6-1.el6.x86_64.rpm",
	"zabbix-get-2.0.6-1.el6.x86_64.rpm",
	"zabbix-sender-2.0.6-1.el6.x86_64.rpm",
	"zabbix-server-2.0.6-1.el6.x86_64.rpm",
	"zabbix-server-mysql-2.0.6-1.el6.x86_64.rpm",
	"zabbix-web-2.0.6-1.el6.noarch.rpm",
	"zabbix-web-japanese-2.0.6-1.el6.noarch.rpm",
	"zabbix-web-mysql-2.0.6-1.el6.noarch.rpm"
]

directory "#{chef_tempdir}"

zabbix_packages.each { |pkg|
	cookbook_file "#{chef_tempdir}/#{pkg}" do
		not_if "rpm -q zabbix-server"
	end
}

zabbix_package_source = []
zabbix_packages.each { |pkg| zabbix_package_source.push("#{chef_tempdir}/#{pkg}") }

execute "install-zabbix-server" do
	notifies :stop, "service[zabbix-server]", :immediate
	notifies :stop, "service[httpd]", :immediate
	command "yum install -y #{zabbix_package_source.join(' ')}"
	notifies :run, "script[create-zabbix-db]", :immediate
	notifies :run, "script[create-zabbix-db-schema]", :immediate
	notifies :run, "script[import-zabbix-db-images]", :immediate
	notifies :run, "script[import-zabbix-db-data]", :immediate
	not_if "rpm -q zabbix-server"
end

template "/etc/zabbix/zabbix_server.conf" do
	mode "640"
	owner "root"
	group "zabbix"
	source "zabbix_server.conf.erb"
end

template "/etc/zabbix/web/zabbix.conf.php" do
	mode "644"
	owner "apache"
	group "apache"
	source "zabbix.conf.php.erb"
end

template "/etc/zabbix/web/maintenance.inc.php" do
	mode "644"
	owner "root"
	group "root"
	source "maintenance.inc.php.erb"
end

script "create-zabbix-db" do
	action :nothing
	interpreter "bash"
	code <<-EOH
		mysql -uroot -p#{node.mysql_server.default_root_password} -h#{node.zabbix_server.db_host} #{(node.zabbix_server.db_port)? "-P"+node.zabbix_server.db_port: ""} <<-EOC
			CREATE DATABASE #{node.zabbix_server.db_name};
			CREATE USER '#{node.zabbix_server.db_user}' IDENTIFIED BY '#{node.zabbix_server.db_password}';
			GRANT ALL PRIVILEGES ON #{node.zabbix_server.db_name}.* TO #{node.zabbix_server.db_user};
			FLUSH PRIVILEGES;
		EOC
	EOH
end

script "create-zabbix-db-schema" do
	action :nothing
	interpreter "bash"
	code <<-EOH
		mysql -u#{node.zabbix_server.db_user} -p#{node.zabbix_server.db_password}\
		 -h#{node.zabbix_server.db_host} #{(node.zabbix_server.db_port)? "-P"+node.zabbix_server.db_port: ""}\
		   #{node.zabbix_server.db_name} < "/usr/share/doc/zabbix-server-mysql-2.0.5/create/schema.sql"
	EOH
end

script "import-zabbix-db-images" do
	action :nothing
	interpreter "bash"
	code <<-EOH
		mysql -u#{node.zabbix_server.db_user} -p#{node.zabbix_server.db_password}\
		 -h#{node.zabbix_server.db_host} #{(node.zabbix_server.db_port)? "-P"+node.zabbix_server.db_port: ""}\
		   #{node.zabbix_server.db_name} < "/usr/share/doc/zabbix-server-mysql-2.0.5/create/images.sql"
	EOH
end

script "import-zabbix-db-data" do
	action :nothing
	interpreter "bash"
	code <<-EOH
		mysql -u#{node.zabbix_server.db_user} -p#{node.zabbix_server.db_password}\
		 -h#{node.zabbix_server.db_host} #{(node.zabbix_server.db_port)? "-P"+node.zabbix_server.db_port: ""}\
		   #{node.zabbix_server.db_name} < "/usr/share/doc/zabbix-server-mysql-2.0.5/create/data.sql"
	EOH
end

service "httpd" do
	action [:enable, :start]
end

service "zabbix-server" do
	action [:enable, :start]
end

service "zabbix-agent" do
	action [:enable, :start]
end
