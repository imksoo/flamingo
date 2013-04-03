# Cookbook Name:: local-account
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

script "timezone" do
	interpreter "bash"
	user "root"
	code <<-EOH
		diff /usr/share/zoneinfo/#{node.timezone.name} /etc/localtime 2>&1 /dev/null
		if [ $? -ne 0 ] ; then
			rm -f /etc/localtime
			cp -p /usr/share/zoneinfo/#{node.timezone.name} /etc/localtime
		fi
	EOH
end
