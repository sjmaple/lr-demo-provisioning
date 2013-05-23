name              "liverebel-tomcat-node"
maintainer        "ZeroTurnaround"
maintainer_email  "liverebel@zeroturnaround.com"
license           "Apache 2.0"
description       "Sets up a Tomcat node for the LiveRebel demo environment"
version           "1.0"
recipe            "liverebel-tomcat-node", "LiveRebel demo Tomcat node"

%w{ debian ubuntu centos suse fedora redhat scientific amazon }.each do |os|
  supports os
end

depends "apt"
depends "java"
depends "liverebel-appserver-agent"
depends "liverebel-sshkey"
depends "liverebel-tomcat7"

attribute "liverebel/tomcat_tunnelport",
  :display_name => "tomcat tunnel port",
  :description => "The port that is used on the remote node to uniquely tunnel to Tomcat on this node",
  :type => "string",
  :required => "required"
