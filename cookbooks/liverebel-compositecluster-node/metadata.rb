name              "liverebel-compositecluster-node"
maintainer        "ZeroTurnaround"
maintainer_email  "liverebel@zeroturnaround.com"
license           "Apache 2.0"
description       "Sets up a composite cluster node for the LiveRebel demo environment"
version           "1.0"
recipe            "liverebel-compositecluster-node", "LiveRebel demo composite cluster node"

%w{ debian ubuntu centos suse fedora redhat scientific amazon }.each do |os|
  supports os
end

depends "apache2"
depends "apache2::mod_proxy"
depends "apache2::mod_proxy_http"
depends "apt"
depends "database::mysql"
depends "java"
depends "liverebel-standalone-agent"
depends "mysql::server"
depends "openssl"
depends "python"
depends "selenium::chrome"
depends "selenium::firefox"
depends "selenium::grid_hub"
depends "selenium::grid_node"

attribute "cluster",
  :display_name => "cluster configuration",
  :description => "Hash of cluster configuration parameters",
  :type => "hash",
  :required => "required"

attribute "cluster/javasessionid",
  :display_name => "java session identifier",
  :description => "Cookie name for sticky sessions on the Java server",
  :type => "string",
  :required => "required"

attribute "cluster/javanodeport",
  :display_name => "http port of nodes",
  :description => "The HTTP port that is used to proxy requests on the clustered nodes to the Tomcat server",
  :type => "string",
  :required => "required"

attribute "cluster/phpsessionid",
  :display_name => "session identifier",
  :description => "Cookie name for sticky sessions on the PHP server",
  :type => "string",
  :required => "required"

attribute "cluster/phpnodeport",
  :display_name => "http port of the php server",
  :description => "The HTTP port that is used to proxy requests on the clustered nodes to the php server",
  :type => "string",
  :required => "required"

attribute "cluster/nodes",
  :display_name => "cluster nodes",
  :description => "IP address of the nodes in the cluster",
  :type => "array",
  :required => "required"