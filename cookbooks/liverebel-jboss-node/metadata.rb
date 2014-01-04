name              "liverebel-jboss-node"
maintainer        "ZeroTurnaround"
maintainer_email  "liverebel@zeroturnaround.com"
license           "Apache 2.0"
description       "Sets up a Tomcat node for the LiveRebel demo environment"
version           "1.0"
recipe            "liverebel-jboss-node", "LiveRebel demo JBoss node"

%w{ debian ubuntu centos suse fedora redhat scientific amazon }.each do |os|
  supports os
end

depends "liverebel-apt"
depends "java"
depends "liverebel-appserver-agent"
depends "liverebel-sshkey"
depends "liverebel-jboss7"

attribute "liverebel/install_agents",
  :display_name => "install LiveRebel agents",
  :description => "Indicates whether the LiveRebel agent should be automatically installed",
  :type => "string",
  :default => "On"

attribute "liverebel/jboss_tunnelport",
  :display_name => "jboss tunnel port",
  :description => "The port that is used on the remote node to uniquely tunnel to JBoss on this node",
  :type => "string",
  :required => "required"

attribute "selenium/base_url",
  :display_name => "Selenium base url",
  :description => "The base URL that will be used to download Selenium binaries from",
  :type => "string",
  :required => "required"
