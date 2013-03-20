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
  group "#{tc7group}"
  command "jar xvf #{selenium_zip}"
  action :nothing
  not_if do
    File.exists?(selenium_installed_path)
  end
end

remote_file selenium_zip_path do
  source "http://selenium.googlecode.com/files/#{selenium_zip}"
  owner tc7user
  group "#{tc7group}"
  mode 00644
  notifies :run, "execute[install-selenium]", :immediately
  not_if do
    File.exists?(selenium_zip_path)
  end
end

# Download and install jboss-logging in the global Tomcat lib directory

jboss_logging_version = "3.1.0.GA"
jboss_logging_jar = "jboss-logging-#{jboss_logging_version}.jar"
jboss_logging_jar_path = "#{tc7home}/lib/#{jboss_logging_jar}"

remote_file jboss_logging_jar_path do
  source "http://repo1.maven.org/maven2/org/jboss/logging/jboss-logging/#{jboss_logging_version}/#{jboss_logging_jar}"
  owner tc7user
  group "#{tc7group}"
  mode 00644
  not_if do
    File.exists?(jboss_logging_jar_path)
  end
end

# Download and install commons-logging in the global Tomcat lib directory

commons_logging_version = "1.1.1"
commons_logging_jar = "commons-logging-#{commons_logging_version}.jar"
commons_logging_jar_path = "#{tc7home}/lib/#{commons_logging_jar}"

remote_file commons_logging_jar_path do
  source "http://repo1.maven.org/maven2/commons-logging/commons-logging/#{commons_logging_version}/#{commons_logging_jar}"
  owner tc7user
  group "#{tc7group}"
  mode 00644
  not_if do
    File.exists?(commons_logging_jar_path)
  end
end


service "tomcat7" do
    service_name "tomcat7"
    action :start
end