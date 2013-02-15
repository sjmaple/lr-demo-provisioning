# -*- mode: ruby -*-
# vi: set ft=ruby :

Vagrant::Config.run do |config|
  config.vm.box = "lucid32"

  config.vm.boot_mode = :headless
  config.vm.customize ["modifyvm", :id, "--memory", 256]

  config.vm.define :loadbalancer do |config|
    config.vm.network :hostonly, "10.127.128.2"
    config.vm.provision :chef_solo do |chef|
      chef_config(chef)
      chef.add_recipe "liverebel-loadbalancer"
      chef.json = {
        :loadbalancer => {
          :context => "lr-demo",
          :nodes => ["10.127.128.3", "10.127.128.4"]
        }
      }
    end
  end

  config.vm.define :web1 do |config|
    config.vm.network :hostonly, "10.127.128.3"
    chef_web(config, 1)
  end

  config.vm.define :web2 do |config|
    config.vm.network :hostonly, "10.127.128.4"
    chef_web(config, 2)
  end
end

def chef_config(chef)
  chef.cookbooks_path = "cookbooks"
  chef.data_bags_path = "data_bags"
  chef.roles_path = "roles"
end

def chef_web(config, identifier)
  config.vm.provision :chef_solo do |chef|
    chef_config(chef)
    chef.add_recipe "liverebel-web"
    chef.json = {
      :mysql => {
        :server_root_password => "change_me",
        :server_repl_password => "change_me",
        :server_debian_password => "change_me"
      },
      :tomcat => {
        :jvm_route => identifier
      }
    }
  end
end