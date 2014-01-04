#
# Cookbook Name:: tomcat7
# Recipe:: default
#
# Copyright 2011,
#
# All rights reserved - Do Not Redistribute
#

include_recipe "java"


tc7ver = node["tomcat7"]["version"]
tc7tarball = "apache-tomcat-#{tc7ver}.tar.gz"
tc7url = "http://archive.apache.org/dist/tomcat/tomcat-7/v#{tc7ver}/bin/#{tc7tarball}"
tc7target = node["tomcat7"]["target"]
tc7user = node["tomcat7"]["user"]
tc7group = node["tomcat7"]["group"]
tc7install = "#{tc7target}/apache-tomcat-#{tc7ver}"

# Create group
group "#{tc7group}" do
    action :create
end

# Create user
user "#{tc7user}" do
    comment "Tomcat7 user"
    gid "#{tc7group}"
    home "#{tc7target}/tomcat"
    shell "/bin/false"
    system true
    action :create
end

# Create base folder
directory tc7install do
    owner "#{tc7user}"
    group "#{tc7group}"
    mode "0755"
    action :create
end

# Get the tomcat binary 
log "Downloading #{tc7url}"
remote_file "/tmp/#{tc7tarball}" do
    source "#{tc7url}"
    mode "0644"
    action :create
    notifies :run, "execute[tar]", :immediately
    not_if do
        File.exists?("#{tc7install}/conf")
    end
end

# Extract
log "Untarring /tmp/#{tc7tarball}"
execute "tar" do
    user "#{tc7user}"
    group "#{tc7group}"
    installation_dir = "#{tc7target}"
    cwd installation_dir
    command "tar zxf /tmp/#{tc7tarball}"
    action :nothing
end

# Set the symlink
link "#{tc7target}/tomcat" do
    to "#{tc7install}"
    link_type :symbolic
end

# Add the init-script
case node["platform"]
when "debian","ubuntu"
    template "/etc/init.d/tomcat7" do
        source "init-debian.erb"
        owner "root"
        group "root"
        mode "0755"
    end
    execute "init-deb" do
        user "root"
        group "root"
        command "update-rc.d tomcat7 defaults"
        action :run
    end
end

# Config from template
template "#{tc7target}/tomcat/conf/server.xml" do
    source "server.xml.erb"
    owner "#{tc7user}"
    group "#{tc7group}"
    mode "0644"
end
