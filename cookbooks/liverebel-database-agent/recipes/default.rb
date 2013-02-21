database_agent_installer_jar_path = "/home/vagrant/lr-database-agent-installer.jar"
database_agent_installed_path = "/home/vagrant/lr-agent"

execute "install-database-agent" do
  cwd "/home/vagrant/"
  user "vagrant"
  command "/usr/bin/java -Dliverebel.host=#{node['liverebel']['host']} -jar /home/vagrant/lr-database-agent-installer.jar"
  action :nothing
  not_if do
    File.exists?(database_agent_installed_path)
  end
end

remote_file database_agent_installer_jar_path do
  source "https://#{node['liverebel']['host']}:9001/public/lr-database-agent-installer.jar"
  owner "vagrant"
  mode 00644
  notifies :run, "execute[install-database-agent]", :immediately
  not_if do
    File.exists?(database_agent_installer_jar_path)
  end
end

execute "run-database-agent" do
  cwd "/home/vagrant/"
  user "vagrant"
  command "#{database_agent_installed_path}/bin/agent.sh&"
end
