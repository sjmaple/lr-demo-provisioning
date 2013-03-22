gem_package "vagrant-vbguest" do
  action :install
end

include_recipe "liverebel-sshkey"
include_recipe "apt"
include_recipe "java"
include_recipe "liverebel-tomcat7"
include_recipe "liverebel-appserver-agent"

tc7user = node["tomcat7"]["user"]
tc7group = node["tomcat7"]["group"]
tc7home = node["tomcat7"]["home"]

# Download and install Selenium

selenium_version = "2.31.0"
selenium_zip = "selenium-java-#{selenium_version}.zip"
selenium_zip_path = "#{tc7home}/#{selenium_zip}"
selenium_installed_path = "#{tc7home}/selenium-2.31.0"

execute "install-selenium" do
  cwd tc7home
  user tc7user
  group tc7group
  command "jar xvf #{selenium_zip}"
  action :nothing
  not_if do
    File.exists?(selenium_installed_path)
  end
end

remote_file selenium_zip_path do
  source "http://selenium.googlecode.com/files/#{selenium_zip}"
  owner tc7user
  group tc7group
  mode 00644
  notifies :run, "execute[install-selenium]", :immediately
  not_if do
    File.exists?(selenium_zip_path)
  end
end

# start the tomcat service

service "tomcat7" do
    service_name "tomcat7"
    action :start
end

# install the vagrant private ssh key

vagrant_sshkey tc7home do
  owner tc7user
  group tc7group
end

# store the tunnel port in a file

template "#{tc7home}/tunnelport" do
  source "tunnelport.erb"
  owner tc7user
  group tc7group
  mode 00640
end
