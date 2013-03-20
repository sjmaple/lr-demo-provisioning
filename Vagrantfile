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
@lr_ip_compositecluster = "#{@lr_subnet}.8"
@lr_ip_composite1 = "#{@lr_subnet}.9"
@lr_ip_composite2 = "#{@lr_subnet}.10"

Vagrant.configure("2") do |config|
  config.vm.box = "precise32"

  config.vm.provider :virtualbox do |vb|
    vb.gui = false
    vb.customize ["modifyvm", :id, "--memory", 384]
  end

  config.vm.define :tomcatcluster do |config|
    config.vm.network :private_network, ip: @lr_ip_tomcatcluster
    config.vm.provision :chef_solo do |chef|
      chef_config(chef)
      chef_hosts_config(chef)
      chef.add_recipe "liverebel-cluster-node"
      chef_cluster_config(chef, @lr_ip_tomcatcluster)
      chef.json.deep_merge!({
        :cluster => {
          :sessionid => "JSESSIONID|jsessionid",
          :nodeport => 8080,
          :scolonpathdelim => true,
          :nodes => [@lr_ip_tomcat1, @lr_ip_tomcat2]
        }
      })
    end
  end

  config.vm.define :tomcat1 do |config|
    chef_tomcat(config, @lr_ip_tomcat1, 1)
  end

  config.vm.define :tomcat2 do |config|
    chef_tomcat(config, @lr_ip_tomcat2, 2)
  end

  config.vm.define :phpcluster do |config|
    config.vm.network :private_network, ip: @lr_ip_phpcluster
    config.vm.provision :chef_solo do |chef|
      chef_config(chef)
      chef_hosts_config(chef)
      chef.add_recipe "liverebel-cluster-node"
      chef_cluster_config(chef, @lr_ip_phpcluster)
      chef.json.deep_merge!({
        :cluster => {
          :sessionid => "BALANCEID",
          :nodeport => 80,
          :nodes => [@lr_ip_php1, @lr_ip_php2]
        }
      })
    end
  end

  config.vm.define :php1 do |config|
    chef_php(config, @lr_ip_php1, 1)
  end

  config.vm.define :php2 do |config|
    chef_php(config, @lr_ip_php2, 2)
  end

  config.vm.define :compositecluster do |config|
    config.vm.network :hostonly, @lr_ip_compositecluster
    config.vm.provision :chef_solo do |chef|
      chef_config(chef)
      chef_hosts_config_composite(chef)
      chef.add_recipe "liverebel-compositecluster-node"
      chef_cluster_config(chef, @lr_ip_compositecluster)
      chef.json.deep_merge!({
        :cluster => {
          :phpsessionid => "BALANCEID",
          :javasessionid => "JSESSIONID|jsessionid",
          :phpnodeport => 80,
          :javanodeport => 8080,
          :nodes => [@lr_ip_composite1, @lr_ip_composite2]
        }
      })
    end
  end

  config.vm.define :composite1 do |config|
    chef_composite(config, @lr_ip_composite1, 1)
  end

  config.vm.define :composite2 do |config|
    chef_composite(config, @lr_ip_composite2, 2)
  end
end

def chef_config(chef)
  chef.cookbooks_path = "cookbooks"
  chef.data_bags_path = "data_bags"
  chef.roles_path = "roles"
end

def chef_hosts_config(chef)
  chef.add_recipe "liverebel-hosts"
  chef.json.deep_merge!({
    :hosts => {
      :host => @lr_ip_host,
      :java => @lr_ip_tomcatcluster,
      :java1 => @lr_ip_tomcat1,
      :java2 => @lr_ip_tomcat2,
      :php => @lr_ip_phpcluster,
      :php1 => @lr_ip_php1,
      :php2 => @lr_ip_php2
    }
  })
end

def chef_hosts_config_composite(chef)
  chef.add_recipe "liverebel-hosts"
  chef.json.deep_merge!({
    :hosts => {
      :host => @lr_ip_host,
      :java => @lr_ip_compositecluster,
      :java1 => @lr_ip_composite1,
      :java2 => @lr_ip_composite2,
      :php => @lr_ip_compositecluster,
      :php1 => @lr_ip_composite1,
      :php2 => @lr_ip_composite2,
      :composite1 => @lr_ip_composite1,
      :composite2 => @lr_ip_composite2
    }
  })
end

def chef_cluster_config(chef, ipAddress)
  chef.json.deep_merge!({
    :liverebel => {
      :hostip => @lr_ip_host,
      :agentip => ipAddress,
      :agent => {
        :user => 'lragent',
        :type => 'database'
      }
    },
    :mysql => {
      :bind_address => ipAddress,
      :allow_remote_root => true,
      :server_user_password => "change_me",
      :server_root_password => "change_me",
      :server_repl_password => "change_me",
      :server_debian_password => "change_me"
    }
  })
end

def chef_tomcat_config(chef, ipAddress, identifier)
  chef.add_recipe "liverebel-tomcat-node"
  chef.json.deep_merge!({
    :liverebel => {
      :hostip => @lr_ip_host,
      :agentip => ipAddress,
      :tunnelport => 18080+identifier
    },
    :tomcat => {
      :jvm_route => identifier
    }
  })
end

def chef_php_config(chef, ipAddress, identifier)
  chef.add_recipe "liverebel-php-node"
  chef.json.deep_merge!({
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
      :server_route => identifier
    },
    :phpunit => {
      :install_method => "pear",
      :version => "3.7.14"
    }
  })
end

def chef_tomcat(config, ipAddress, identifier)
  config.vm.network :private_network, ip: ipAddress
  config.vm.provision :chef_solo do |chef|
    chef_config(chef)
    chef_hosts_config(chef)
    chef_tomcat_config(chef, ipAddress, identifier)
  end
end

def chef_php(config, ipAddress, identifier)
  config.vm.network :private_network, ip: ipAddress
  config.vm.provision :chef_solo do |chef|
    chef_config(chef)
    chef_hosts_config(chef)
    chef_php_config(chef, ipAddress, identifier)
  end
end

def chef_composite(config, ipAddress, identifier)
  config.vm.network :hostonly, ipAddress
  config.vm.provision :chef_solo do |chef|
    chef_config(chef)
    chef_hosts_config_composite(chef)
    chef_php_config(chef, ipAddress, identifier)
    chef_tomcat_config(chef, ipAddress, identifier)
  end
end

class Hash
  def deep_merge(other_hash, &block)
    dup.deep_merge!(other_hash, &block)
  end

  def deep_merge!(other_hash, &block)
    other_hash.each_pair do |k,v|
      tv = self[k]
      if tv.is_a?(Hash) && v.is_a?(Hash)
        self[k] = tv.deep_merge(v, &block)
      else
        self[k] = block && tv ? block.call(k, tv, v) : v
      end
    end
    self
  end
end
