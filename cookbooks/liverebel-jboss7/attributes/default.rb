#
# Cookbook Name:: jboss7
# Attributes:: default
#
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
# http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
#

default[:jboss7][:version] = "7.1.1"
default[:jboss7][:user] = "jboss"
default[:jboss7][:group] = "jboss"
default[:jboss7][:target] = "/usr/share"
default[:jboss7][:port] = 8080
default[:jboss7][:management_port] = 8090
default[:jboss7][:ssl_port] = 8443
default[:jboss7][:ajp_port] = 8009

##
set[:jboss7][:home] = "#{jboss7['target']}/jboss"
