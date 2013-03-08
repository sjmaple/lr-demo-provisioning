include_recipe "apt"
include_recipe "java"
include_recipe "liverebel-tomcat7"
include_recipe "liverebel-appserver-agent"

service "tomcat7" do
    service_name "tomcat7"
    action :start
end