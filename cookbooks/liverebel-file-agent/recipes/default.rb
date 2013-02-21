file_agent_installer_jar_path = "/home/vagrant/lr-file-agent-installer.jar"
file_agent_installed_path = "/home/vagrant/lr-agent"

execute "install-file-agent" do
  cwd "/home/vagrant/"
  user "vagrant"
  command "/usr/bin/java -DserverHome=/var/www -Dliverebel.host=#{node['liverebel']['host']} -jar /home/vagrant/lr-file-agent-installer.jar"
  action :nothing
  not_if do
    File.exists?(file_agent_installed_path)
  end
end

remote_file file_agent_installer_jar_path do
  source "https://#{node['liverebel']['host']}:9001/public/lr-file-agent-installer.jar"
  owner "vagrant"
  mode 00644
  notifies :run, "execute[install-file-agent]", :immediately
  not_if do
    File.exists?(file_agent_installer_jar_path)
  end
end

execute "run-file-agent" do
  command "#{file_agent_installed_path}/bin/agent.sh&"
end