# -*- mode: ruby -*-
# vi: set ft=ruby :

@lr_subnet = "10.127.128"
@lr_ip_host = "#{@lr_subnet}.1"
@lr_ip_tomcatcluster = "#{@lr_subnet}.2"
@lr_ip_tomcat1 = "#{@lr_subnet}.3"
@lr_ip_tomcat2 = "#{@lr_subnet}.4"
@lr_ip_phpcluster = "#{@lr_subnet}.5"
@lr_ip_php1 = "#{@lr_subnet}.6"
@lr_ip_php2 = "#{@lr_subnet}.7"

Vagrant::Config.run do |config|
  config.vm.box = "precise32"

  config.vm.boot_mode = :headless
  config.vm.customize ["modifyvm", :id, "--memory", 384]

  config.vm.define :tomcatcluster do |config|
    config.vm.network :hostonly, @lr_ip_tomcatcluster
    config.vm.provision :chef_solo do |chef|
      chef_config(chef)
      chef.add_recipe "liverebel-cluster-node"
      chef.json = {
        :liverebel => {
          :hostip => @lr_ip_host,
          :agentip => @lr_ip_tomcatcluster,
          :agent => {
            :user => 'lragent',
            :type => 'database'
          }
        },
        :cluster => {
          :sessionid => "JSESSIONID|jsessionid",
          :nodeport => 8080,
          :scolonpathdelim => true,
          :nodes => [@lr_ip_tomcat1, @lr_ip_tomcat2]
        },
        :mysql => {
          :bind_address => @lr_ip_tomcatcluster,
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
    chef_tomcat(config, @lr_ip_tomcat1, 1)
  end

  config.vm.define :tomcat2 do |config|
    chef_tomcat(config, @lr_ip_tomcat2, 2)
  end

  config.vm.define :phpcluster do |config|
    config.vm.network :hostonly, @lr_ip_phpcluster
    config.vm.provision :chef_solo do |chef|
      chef_config(chef)
      chef.add_recipe "liverebel-cluster-node"
      chef.json = {
        :liverebel => {
          :hostip => @lr_ip_host,
          :agentip => @lr_ip_phpcluster,
          :agent => {
            :user => 'lragent',
            :type => 'database'
          }
        },
        :cluster => {
          :sessionid => "BALANCEID",
          :nodeport => 80,
          :nodes => [@lr_ip_php1, @lr_ip_php2]
        },
        :mysql => {
          :bind_address => @lr_ip_phpcluster,
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
    chef_php(config, @lr_ip_php1, 1)
  end

  config.vm.define :php2 do |config|
    chef_php(config, @lr_ip_php2, 2)
  end
end

def chef_config(chef)
  chef.cookbooks_path = "cookbooks"
  chef.data_bags_path = "data_bags"
  chef.roles_path = "roles"
end

def chef_tomcat(config, ipAddress, identifier)
  config.vm.network :hostonly, ipAddress
  config.vm.provision :chef_solo do |chef|
    chef_config(chef)
    chef.add_recipe "liverebel-tomcat-node"
    chef.json = {
      :liverebel => {
        :hostip => @lr_ip_host,
        :agentip => ipAddress
      },
      :tomcat => {
        :jvm_route => identifier
      }
    }
  end
end

def chef_php(config, ipAddress, identifier)
  config.vm.network :hostonly, ipAddress
  config.vm.provision :chef_solo do |chef|
    chef_config(chef)
    chef.add_recipe "liverebel-php-node"
    chef.json = {
        :liverebel => {
          :hostip => @lr_ip_host,
          :agentip => ipAddress,
          :agent => {
            :user => 'lragent',
            :group => 'www-data',
            :type => 'file'
          }
        },
        :php => {
          :server_route => identifier,
          :balance_cookie_ip => @lr_ip_phpcluster
        },
        :phpunit => {
          :install_method => "pear",
          :version => "3.7.14"
        }
      }
  end
end