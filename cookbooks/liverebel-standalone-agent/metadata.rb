name              "liverebel-standalone-agent"
maintainer        "ZeroTurnaround"
maintainer_email  "liverebel@zeroturnaround.com"
license           "Apache 2.0"
description       "Installs and configures a standalone LiveRebel agent with init script"
version           "1.0"
recipe            "liverebel-standalone-agent", "LiveRebel standalone agent"

%w{ debian ubuntu }.each do |os|
  supports os
end

depends "liverebel-sshkey"

attribute "liverebel",
  :display_name => "liverebel configuration",
  :description => "Hash of LiveRebel configuration parameters",
  :type => "hash",
  :required => "required"

attribute "liverebel/agentip",
  :display_name => "agent IP",
  :description => "The IP address of the machine the agent is running on",
  :type => "string",
  :required => "required"

attribute "liverebel/hostip",
  :display_name => "host IP",
  :description => "The IP address of the host machine on which LiveRebel Command Center is running",
  :type => "string",
  :required => "required"

attribute "liverebel/agent",
  :display_name => "agent configuration",
  :description => "Hash of agent configuration parameters",
  :type => "hash",
  :required => "required"

attribute "liverebel/agent/user",
  :display_name => "agent user",
  :description => "The user name that will the agent will be ran with",
  :type => "string",
  :required => "required"

attribute "liverebel/agent/group",
  :display_name => "agent group",
  :description => "The user group that will the agent will be ran with",
  :type => "string",
  :required => "required"

attribute "liverebel/agent/type",
  :display_name => "agent type",
  :description => "The type of agent that has to be installed",
  :choice => [ "file", "database" ],
  :type => "string",
  :required => "required"

attribute "liverebel/php_tunnelport",
  :display_name => "php tunnel port",
  :description => "The port that is used on the remote node to uniquely tunnel to the PHP server this node",
  :type => "string",
  :required => "optional"
