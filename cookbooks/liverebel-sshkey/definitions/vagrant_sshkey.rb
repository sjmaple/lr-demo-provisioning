#
# Cookbook Name:: liverebel-sshkey
# Definition:: vagrant_sshkey
#
# Copyright 2013, ZeroTurnaround
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

define :vagrant_sshkey do
  sshkey_url = "https://raw.github.com/mitchellh/vagrant/master/keys/vagrant"
  ssh_dir = "#{params[:name]}/.ssh"
  sshkey_path = "#{ssh_dir}/id_dsa"

  directory ssh_dir do
    owner params[:owner]
    group params[:group]
    mode 0700
    action :create
  end

  remote_file sshkey_path do
    source sshkey_url
    owner params[:owner]
    group params[:group]
    mode 00600
    not_if do
      File.exists?(sshkey_path)
    end
  end
end
