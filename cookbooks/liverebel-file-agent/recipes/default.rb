execute "install-file-agent" do
  cwd "/home/vagrant/"
  command "/usr/bin/java -jar /home/vagrant/lr-file-agent-installer.jar"
  action :nothing
end

execute "run-file-agent" do
  cwd "/home/vagrant/"
  command "/home/vagrant/lr-agent/bin/agent.sh&"
  action :nothing
end

remote_file "/home/vagrant/lr-file-agent-installer.jar" do
  source "https://10.127.128.1:9001/public/lr-file-agent-installer.jar"
  mode 00644
  notifies :run, "execute[install-file-agent]", :immediately
  notifies :run, "execute[run-file-agent]", :immediately
end
