maintainer       "Vladislav Mikhaylov"
maintainer_email "solarvm@gmail.com"
license          "AGPL"
description      "Installs/Configures tomcat7 binary distrib"
long_description IO.read(File.join(File.dirname(__FILE__), 'README.md'))
version          "0.0.3"

recipe "tomcat7::default", "Installs and configures Tomcat7"

%w{ debian ubuntu centos redhat fedora }.each do |os|
  supports os
end

attribute "tomcat",
  :display_name => "tomcat config",
  :description => "Hash of Tomcat configuration parameters",
  :type => "hash",
  :required => "required"

attribute "tomcat/jvm_route",
  :display_name => "Tomcat server route",
  :description => "Unique identifier that is used to route request to the Tomcat node from the cluster node. This should correspond to the position of this node's IP address in the cluster node's nodes attribute.",
  :type => "string",
  :required => "required"