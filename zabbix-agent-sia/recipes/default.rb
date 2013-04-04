#
# Cookbook Name:: zabbix-agent-sia
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
	"zabbix-2.0.5-1.el6.x86_64.rpm",
	"zabbix-agent-2.0.5-1.el6.x86_64.rpm",
	"zabbix-get-2.0.5-1.el6.x86_64.rpm",
	"zabbix-sender-2.0.5-1.el6.x86_64.rpm",
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
	notifies :stop, "service[zabbix-agent]", :immediate
	command "yum install -y #{zabbix_package_source.join(' ')}"
	not_if "rpm -q zabbix-agent"
end

template "/etc/zabbix/zabbix_agentd.conf" do
	mode "644"
	owner "root"
	group "root"
	source "zabbix_agentd.conf.erb"
	notifies :restart, "service[zabbix-agent]", :delayed
end

directory "/etc/zabbix/zabbix_agentd.d"

service "zabbix-agent" do
	supports :restart=>true
	action [:enable, :start]
end

