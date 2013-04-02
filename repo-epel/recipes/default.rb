#
# Cookbook Name:: repo-epel
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

chef_tmpdir = "/tmp/chef"
epel_rpmfile= "epel-release-6-8.noarch.rpm"

directory "#{chef_tmpdir}"
cookbook_file "#{chef_tmpdir}/#{epel_rpmfile}"

yum_package "epel-release" do
	action :install
	source "#{chef_tmpdir}/#{epel_rpmfile}"
end

bash "remove-rpmfile" do
	code <<-EOH
		rm -f #{chef_tmpdir}/#{epel_rpmfile}
	EOH
end
