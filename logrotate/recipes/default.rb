#
# Cookbook Name:: logrotate
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

template "/etc/logrotate.conf" do
	mode 644
	owner "root"
	group "root"
	source "logrotate.conf.erb"
end

directory "/etc/logrotate.d" do
	mode 755
	owner "root"
	group "root"
end

template "/etc/logrotate.d/syslog" do
	mode 644
	owner "root"
	group "root"
	source "syslog.erb"
end

