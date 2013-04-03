#
# Cookbook Name:: php
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

yum_package "php"

template "/etc/php.ini" do
	mode "644"
	owner "root"
	group "root"
	source "php.ini.erb"
	notifies :restart, "service[httpd]", :delayed
end

directory "/etc/php.d"

service "httpd" do
	action :nothing
end