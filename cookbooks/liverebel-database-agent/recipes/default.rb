agent_installer_jar = "lr-database-agent-installer.jar"
agent_installer_jar_path = "/home/vagrant/#{agent_installer_jar}"
agent_installed_path = "/home/vagrant/lr-agent"

execute "install-database-agent" do
  cwd "/home/vagrant/"
  user "vagrant"
  command "/usr/bin/java -Dliverebel.host=#{node['liverebel']['host']} -jar #{agent_installer_jar_path}"
  action :nothing
  not_if do
    File.exists?(agent_installed_path)
  end
end

remote_file agent_installer_jar_path do
  source "https://#{node['liverebel']['host']}:9001/public/#{agent_installer_jar}"
  owner "vagrant"
  mode 00644
  notifies :run, "execute[install-database-agent]", :immediately
  not_if do
    File.exists?(agent_installer_jar_path)
  end
end

execute "run-database-agent" do
  cwd "/home/vagrant/"
  user "vagrant"
  command "#{agent_installed_path}/bin/agent.sh&"
end
