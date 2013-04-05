#
# Cookbook Name:: snmptt
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

chef_tempdir = "/tmp/chef/snmptt"

snmptt_packages =  %w[
	perl-5.10.1-130.el6_4.x86_64.rpm
	perl-Config-IniFiles-2.72-2.el6.noarch.rpm
	perl-Crypt-DES-2.05-9.el6.x86_64.rpm
	perl-Digest-HMAC-1.01-22.el6.noarch.rpm
	perl-Digest-SHA1-2.12-2.el6.x86_64.rpm
	perl-IO-stringy-2.110-10.1.el6.noarch.rpm
	perl-List-MoreUtils-0.22-10.el6.x86_64.rpm
	perl-Net-SNMP-5.2.0-4.el6.noarch.rpm
	perl-Time-HiRes-1.9721-130.el6_4.x86_64.rpm
	net-snmp-5.5-44.el6.x86_64.rpm
	net-snmp-utils-5.5-44.el6.x86_64.rpm
	snmptt-1.4-0.6.beta2.el6.noarch.rpm
]

directory "#{chef_tempdir}"

snmptt_packages.each { |pkg|
	cookbook_file "#{chef_tempdir}/#{pkg}" do
		not_if "rpm -q snmptt"
	end
}

snmptt_package_source = []
snmptt_packages.each { |pkg| snmptt_package_source.push("#{chef_tempdir}/#{pkg}") }

execute "install-snmptt" do
	notifies :stop, "service[snmptt]", :immediate
	command "yum install -y #{snmptt_package_source.join(' ')}"
	not_if "rpm -q snmptt"
end

template "/etc/snmp/snmpd.conf" do
	mode 644
	owner "root"
	group "root"
	source "snmpd.conf.erb"
end

template "/etc/snmp/snmptrapd.conf" do
	mode 644
	owner "root"
	group "root"
	source "snmptrapd.conf.erb"
end

template "/etc/snmp/snmptt.conf" do
	mode 644
	owner "root"
	group "root"
	source "snmptt.conf.erb"
end

template "/etc/snmp/snmptt.ini" do
	mode 644
	owner "root"
	group "root"
	source "snmptt.ini.erb"
end

template "/etc/rc.d/init.d/snmptrapd" do
	mode 755
	owner "root"
	group "root"
	source "snmptrapd.erb"
end

service "snmptrapd" do
	action [:enable, :start]
end

service "snmptt" do
	action [:enable, :start]
end

