name              "liverebel-apt"
maintainer        "ZeroTurnaround"
maintainer_email  "liverebel@zeroturnaround.com"
license           "Apache 2.0"
description       "Sets up APT just like the standard cookbook, but ensures that only one specific repository is used and no other"
version           "1.0"
recipe            "liverebel-apt", "LiveRebel APT"

%w{ debian ubuntu centos suse fedora redhat scientific amazon }.each do |os|
  supports os
end

depends "apt"

attribute "apt/repository",
  :display_name => "APT repository",
  :description => "The APT repository that will used for all package operations",
  :type => "string",
  :required => "required"
