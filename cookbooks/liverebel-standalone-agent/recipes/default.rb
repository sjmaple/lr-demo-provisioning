agent_user = node['liverebel']['agent']['user']
agent_group = node['liverebel']['agent']['group']
agent_type = node['liverebel']['agent']['type']
agent_user_home = "/opt/#{agent_user}"
agent_installer_jar = "lr-#{agent_type}-agent-installer.jar"
agent_installer_jar_path = "#{agent_user_home}/#{agent_installer_jar}"
agent_installed_path = "#{agent_user_home}/lr-agent"

user "create_agent_user" do
  comment "LiveRebel agent user"
  username agent_user
  home "#{agent_user_home}"
  manage_home true
  if agent_group
    gid agent_group
  end
  shell "/bin/bash"
  action :create
end

ruby_block 'update-agent-properties' do
  action :nothing
  block do
    file = Chef::Util::FileEdit.new("#{agent_installed_path}/conf/lr-agent.properties")
    file.insert_line_if_no_match("/agent.host/", "agent.host=#{node['liverebel']['agentip']}")
    file.write_file
  end
end

execute "install-agent" do
  cwd agent_user_home
  user agent_user
  command "/usr/bin/java -Dliverebel.host=#{node['liverebel']['hostip']} -jar #{agent_installer_jar_path}"
  action :nothing
  notifies :create, "ruby_block[update-agent-properties]", :immediately
  not_if do
    File.exists?(agent_installed_path)
  end
end

remote_file agent_installer_jar_path do
  source "https://#{node['liverebel']['hostip']}:9001/public/#{agent_installer_jar}"
  owner agent_user
  mode 00644
  notifies :run, "execute[install-agent]", :immediately
  not_if do
    File.exists?(agent_installer_jar_path)
  end
end

case node["platform"]
when "debian","ubuntu"
  template "/etc/init.d/lragent" do
    source "init-debian.erb"
    owner "root"
    group "root"
    mode "0755"
    variables(
      :lragent_user => agent_user,
      :lragent_home => agent_installed_path
    )
  end
  execute "init-deb" do
    user "root"
    group "root"
    command "update-rc.d lragent defaults"
    action :run
    end
end

service "lragent" do
    service_name "lragent"
    action :start
end