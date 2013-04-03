#
# Cookbook Name:: httpd
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

yum_package "httpd"

directory "/etc/httpd/conf"

template "/etc/httpd/conf/httpd.conf" do
	mode "644"
	owner "root"
	group "root"
	source "httpd.conf.erb"
	notifies :reload, "service[httpd]", :delayed
end

template "/etc/httpd/conf/magic" do
	mode "644"
	owner "root"
	group "root"
	source "magic.erb"
	notifies :reload, "service[httpd]", :delayed
end

directory "/etc/httpd/conf.d"

service "httpd" do
	supports :reload=>true
	action [:enable, :start]
end
