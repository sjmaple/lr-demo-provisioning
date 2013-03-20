name              "liverebel-sshkey"
maintainer        "ZeroTurnaround"
maintainer_email  "liverebel@zeroturnaround.com"
license           "Apache 2.0"
description       "Sets up the insecure Vagrant private SSH key on all LiveRebel nodes"
version           "1.0"
recipe            "liverebel-sshkey", "LiveRebel private SSH key"

%w{ debian ubuntu centos suse fedora redhat scientific amazon }.each do |os|
  supports os
end