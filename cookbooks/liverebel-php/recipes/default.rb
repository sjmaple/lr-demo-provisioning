include_recipe "apt"
include_recipe "java"
include_recipe "php"
include_recipe "phpunit"
include_recipe "apache2"
include_recipe "apache2::mod_php5"
include_recipe "apache2::mod_rewrite"
include_recipe "liverebel-file-agent"

package "php5-mysql" do
  action :install
end

execute "enable-default-site" do
  command "sudo a2ensite default"
  notifies :reload, resources(:service => "apache2"), :delayed
end