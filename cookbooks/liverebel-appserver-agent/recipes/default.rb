tc7user = node["tomcat7"]["user"]
tc7group = node["tomcat7"]["group"]
tc7home = node["tomcat7"]["home"]
appserver_agent_installer_jar = "lr-agent-installer.jar"
appserver_agent_installer_jar_path = "#{tc7home}/#{appserver_agent_installer_jar}"
appserver_agent_installed_path = "#{tc7home}/lr-agent"

ruby_block 'update-appserver-agent-properties' do
  action :nothing
  block do
    file = Chef::Util::FileEdit.new("#{appserver_agent_installed_path}/conf/lr-agent.properties")
    file.insert_line_if_no_match("/agent.host/", "agent.host=#{node['liverebel']['agentip']}")
    file.write_file
  end
end

execute "install-appserver-agent" do
  cwd tc7home
  user tc7user
  group tc7group
  command "/usr/bin/java -Dliverebel.agent.token=vagrant -Dliverebel.host=#{node['liverebel']['hostip']} -jar #{appserver_agent_installer_jar_path}"
  action :nothing
  notifies :create, "ruby_block[update-appserver-agent-properties]", :immediately
  not_if do
    File.exists?(appserver_agent_installed_path)
  end
end

remote_file appserver_agent_installer_jar_path do
  source "https://#{node['liverebel']['hostip']}:9001/public/#{appserver_agent_installer_jar}"
  owner tc7user
  group tc7group
  mode 00644
  notifies :run, "execute[install-appserver-agent]", :immediately
  not_if do
    File.exists?(appserver_agent_installer_jar_path)
  end
end