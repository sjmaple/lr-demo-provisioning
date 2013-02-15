include_recipe "openssl"
include_recipe "apt"
include_recipe "apache2"
include_recipe "apache2::mod_proxy"
include_recipe "apache2::mod_proxy_http"

apache_module "proxy_balancer" do
  conf true
end

execute "disable-default-site" do
  command "sudo a2dissite default"
  notifies :reload, resources(:service => "apache2"), :delayed
end
