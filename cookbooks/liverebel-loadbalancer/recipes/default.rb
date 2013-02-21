include_recipe "openssl"
include_recipe "apt"
include_recipe "apache2"
include_recipe "apache2::mod_proxy"
include_recipe "apache2::mod_proxy_http"
include_recipe "mysql::server"
include_recipe "java"
include_recipe "python"
include_recipe "selenium::firefox"
include_recipe "selenium::chrome"
include_recipe "selenium::grid_hub"
include_recipe "selenium::grid_node"
include_recipe "liverebel-database-agent"

apache_module "proxy_balancer" do
  conf true
end

execute "disable-default-site" do
  command "sudo a2dissite default"
  notifies :reload, resources(:service => "apache2"), :delayed
end
