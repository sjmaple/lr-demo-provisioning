vagrant_sshkey_url = "https://raw.github.com/mitchellh/vagrant/master/keys/vagrant"
vagrant_sshkey_path = "/home/vagrant/.ssh/id_dsa"

remote_file vagrant_sshkey_path do
  source vagrant_sshkey_url
  owner "vagrant"
  group "vagrant"
  mode 00600
  not_if do
    File.exists?(vagrant_sshkey_path)
  end
end
