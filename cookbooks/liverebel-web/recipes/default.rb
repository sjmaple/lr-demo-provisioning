include_recipe "openssl"
include_recipe "apt"
include_recipe "apache2"
include_recipe "apache2::mod_php5"
include_recipe "mysql::server"
include_recipe "java"
include_recipe "tomcat"
include_recipe "tomcat::users"

execute "disable-default-site" do
  command "sudo a2dissite default"
  notifies :reload, resources(:service => "apache2"), :delayed
end

web_app "project" do
  template "project.conf.erb"
  notifies :reload, resources(:service => "apache2"), :delayed
end
