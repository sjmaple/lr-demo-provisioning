name              "liverebel-cluster-node"
maintainer        "ZeroTurnaround"
maintainer_email  "liverebel@zeroturnaround.com"
license           "Apache 2.0"
description       "Sets up a cluster node for the LiveRebel demo environment"
version           "1.0"
recipe            "liverebel-cluster-node", "LiveRebel demo cluster node"

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

attribute "cluster/sessionid",
  :display_name => "session identifier",
  :description => "IP address of the host machine",
  :type => "string",
  :required => "required"

attribute "cluster/nodeport",
  :display_name => "http port of nodes",
  :description => "The HTTP port that is used to proxy requests on the clustered nodes to",
  :type => "string",
  :required => "required"

attribute "cluster/nodes",
  :display_name => "cluster nodes",
  :description => "IP address of the nodes in the cluster",
  :type => "array",
  :required => "required"

attribute "cluster/scolonpathdelim",
  :display_name => "semi colon path delimitation",
  :description => "Use semi-colon character as an additional sticky session path deliminator/separator",
  :type => "string",
  :required => "optional"