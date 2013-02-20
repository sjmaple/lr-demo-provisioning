include_recipe 'selenium::default'
include_recipe 'java'
include_recipe 'selenium::xvfb'


template File.join(node['selenium']['server']['installpath'], 'nodeConfig.json') do
  source "nodeConfig.json.erb"
  mode 0644
  owner node['selenium']['user']
  group node['selenium']['user']
end

SERVNAME='run-node'
script_path=node['selenium']['home']+'init/'+SERVNAME+'.sh'

template script_path do
  source SERVNAME+'.erb'
  mode 0755
  owner node['selenium']['user']
  group node['selenium']['user']
end

link "/etc/init.d/"+SERVNAME do
  to script_path
end

case node["platform"]
  when "centos","redhat","fedora"
     execute "update_rc_for_reg-agent" do
	user "root"
	group "root"
	cwd "/etc/init.d"
	command <<-EOH
        chkconfig --add #{SERVNAME} || echo 'service #{SERVNAME} already registred'
	EOH
     end
  when "debian","ubuntu"
     execute "update_rc_for_reg-agent" do
	user "root"
	group "root"
	cwd "/etc/init.d"
	command <<-EOH
        update-rc.d #{SERVNAME} defaults 98 02 || echo 'service #{SERVNAME} already registred'
	EOH
    end
end

service SERVNAME do
  supports :restart => true
  action :restart
end
