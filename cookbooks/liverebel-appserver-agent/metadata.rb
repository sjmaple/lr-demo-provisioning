name              "liverebel-appserver-agent"
maintainer        "ZeroTurnaround"
maintainer_email  "liverebel@zeroturnaround.com"
license           "Apache 2.0"
description       "Configures the LiveRebel agent for the Tomcat servlet container"
version           "1.0"
recipe            "liverebel-appserver-agent", "LiveRebel agent for the Tomcat servlet container"

%w{ debian ubuntu centos suse fedora redhat scientific amazon }.each do |os|
  supports os
end

attribute "liverebel/install_agents",
  :display_name => "install LiveRebel agents",
  :description => "Indicates whether the LiveRebel agent should be automatically installed",
  :type => "string",
  :default => "On"
