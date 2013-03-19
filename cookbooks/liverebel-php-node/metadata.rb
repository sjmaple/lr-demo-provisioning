name              "liverebel-php-node"
maintainer        "ZeroTurnaround"
maintainer_email  "liverebel@zeroturnaround.com"
license           "Apache 2.0"
description       "Sets up a PHP node for the LiveRebel demo environment"
version           "1.0"
recipe            "liverebel-php-node", "LiveRebel demo PHP node"

%w{ debian ubuntu centos suse fedora redhat scientific amazon }.each do |os|
  supports os
end

depends "apache2"
depends "apache2::mod_php5"
depends "apache2::mod_rewrite"
depends "apt"
depends "java"
depends "liverebel-standalone-agent"
depends "php"
depends "phpunit"

attribute "php",
  :display_name => "php node config",
  :description => "Hash of PHP node configuration parameters",
  :type => "hash",
  :required => "required"

attribute "php/server_route",
  :display_name => "PHP server route",
  :description => "Unique identifier that is used to route request to the PHP node from the cluster node. This should correspond to the position of this node's IP address in the cluster node's nodes attribute.",
  :type => "string",
  :required => "required"
