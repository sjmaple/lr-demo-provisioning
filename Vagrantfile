# -*- mode: ruby -*-
# vi: set ft=ruby :

Vagrant::Config.run do |config|
  config.vm.box = "precise32"

  config.vm.boot_mode = :headless
  config.vm.customize ["modifyvm", :id, "--memory", 256]

  config.vm.define :tomcatcluster do |config|
    config.vm.network :hostonly, "10.127.128.2"
    config.vm.provision :chef_solo do |chef|
      chef_config(chef)
      chef.add_recipe "liverebel-loadbalancer"
      chef.json = {
        :loadbalancer => {
          :context => "lr-demo",
          :sessionid => "JSESSIONID|jsessionid",
          :nodeport => 8080,
          :scolonpathdelim => true,
          :nodes => ["10.127.128.3", "10.127.128.4"]
        },
        :mysql => {
          :bind_address => "10.127.128.2",
          :allow_remote_root => true,
          :server_user_password => "change_me",
          :server_root_password => "change_me",
          :server_repl_password => "change_me",
          :server_debian_password => "change_me"
        }
      }
    end
  end

  config.vm.define :tomcat1 do |config|
    config.vm.network :hostonly, "10.127.128.3"
    chef_tomcat(config, 1)
  end

  config.vm.define :tomcat2 do |config|
    config.vm.network :hostonly, "10.127.128.4"
    chef_tomcat(config, 2)
  end

  config.vm.define :phpcluster do |config|
    config.vm.network :hostonly, "10.127.128.5"
    config.vm.provision :chef_solo do |chef|
      chef_config(chef)
      chef.add_recipe "liverebel-loadbalancer"
      chef.json = {
        :loadbalancer => {
          :context => "lr-demo",
          :sessionid => "PHPSESSIONID",
          :nodeport => 80,
          :nodes => ["10.127.128.6", "10.127.128.7"]
        },
        :mysql => {
          :bind_address => "10.127.128.5",
          :allow_remote_root => true,
          :server_user_password => "change_me",
          :server_root_password => "change_me",
          :server_repl_password => "change_me",
          :server_debian_password => "change_me"
        }
      }
    end
  end

  config.vm.define :php1 do |config|
    config.vm.network :hostonly, "10.127.128.6"
    chef_php(config)
  end

  config.vm.define :php2 do |config|
    config.vm.network :hostonly, "10.127.128.7"
    chef_php(config)
  end
end

def chef_config(chef)
  chef.cookbooks_path = "cookbooks"
  chef.data_bags_path = "data_bags"
  chef.roles_path = "roles"
end

def chef_tomcat(config, identifier)
  config.vm.provision :chef_solo do |chef|
    chef_config(chef)
    chef.add_recipe "liverebel-tomcat"
    chef.json = {
      :tomcat => {
        :jvm_route => identifier
      }
    }
  end
end

def chef_php(config)
  config.vm.provision :chef_solo do |chef|
    chef_config(chef)
    chef.add_recipe "liverebel-php"
    chef.json = {
        :phpunit => {
          :install_method => "pear",
          :version => "3.7.14"
        }
      }
  end
end