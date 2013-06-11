include_recipe "apt"

file "/etc/apt/sources.list" do
  action :delete
end

apt_repository "aptmirror" do
  uri "#{node['apt']['repository']}"
  distribution "precise"
  components ["main", "universe"]
end
