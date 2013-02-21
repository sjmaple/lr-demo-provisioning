execute "install-database-agent" do
  cwd "/home/vagrant/"
  user "vagrant"
  command "/usr/bin/java -jar /home/vagrant/lr-database-agent-installer.jar"
  action :nothing
end

execute "run-database-agent" do
  cwd "/home/vagrant/"
  user "vagrant"
  command "/home/vagrant/lr-agent/bin/agent.sh&"
  action :nothing
end

remote_file "/home/vagrant/lr-database-agent-installer.jar" do
  source "https://10.127.128.1:9001/public/lr-database-agent-installer.jar"
  owner "vagrant"
  mode 00644
  notifies :run, "execute[install-database-agent]", :immediately
  notifies :run, "execute[run-database-agent]", :immediately
end
