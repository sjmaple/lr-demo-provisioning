name              "liverebel-hosts"
maintainer        "ZeroTurnaround"
maintainer_email  "liverebel@zeroturnaround.com"
license           "Apache 2.0"
description       "Configures standard host name for the demo environment on the virtual machines"
version           "1.0"
recipe            "liverebel-hosts", "Configures standard host name for the demo environment"

%w{ debian ubuntu centos suse fedora redhat scientific amazon }.each do |os|
  supports os
end

depends "hostsfile"

attribute "hosts",
  :display_name => "hosts addresses",
  :description => "Hash of host IP addresses",
  :type => "hash",
  :required => "required"

attribute "hosts/host",
  :display_name => "host IP",
  :description => "IP address of the host machine",
  :type => "string",
  :required => "required"

attribute "hosts/java",
  :display_name => "java IP",
  :description => "IP address of the cluster for java nodes",
  :type => "string",
  :required => "required"

attribute "hosts/java1",
  :display_name => "java1 IP",
  :description => "IP address of the java1 node",
  :type => "string",
  :required => "required"

attribute "hosts/java2",
  :display_name => "java2 IP",
  :description => "IP address of the java2 node",
  :type => "string",
  :required => "required"

attribute "hosts/php",
  :display_name => "php IP",
  :description => "IP address of the cluster for PHP nodes",
  :type => "string",
  :required => "required"

attribute "hosts/php1",
  :display_name => "php1 IP",
  :description => "IP address of the php1 node",
  :type => "string",
  :required => "required"

attribute "hosts/php2",
  :display_name => "php2 IP",
  :description => "IP address of the php2 node",
  :type => "string",
  :required => "required"

attribute "hosts/jboss",
  :display_name => "jboss IP",
  :description => "IP address of the cluster for JBoss nodes",
  :type => "string",
  :required => "required"

attribute "hosts/jboss1",
  :display_name => "jboss1 IP",
  :description => "IP address of the jboss1 node",
  :type => "string",
  :required => "required"

attribute "hosts/jboss2",
  :display_name => "jboss2 IP",
  :description => "IP address of the jboss2 node",
  :type => "string",
  :required => "required"  