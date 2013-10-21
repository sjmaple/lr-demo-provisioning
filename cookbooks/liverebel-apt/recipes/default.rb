include_recipe "apt"

if !"#{node['apt']['repository']}".empty?
	file "/etc/apt/sources.list" do
	  action :delete
	end

	apt_repository "aptmirror" do
	  uri "#{node['apt']['repository']}"
	  distribution "precise"
	  components ["main", "universe"]
	end
end