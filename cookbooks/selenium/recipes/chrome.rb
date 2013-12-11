include_recipe 'selenium::default'
	
case node['kernel']['machine']
when 'i686'
  arch = 'linux32'
when 'x86_64'
  arch = 'linux64'
end

package 'chromium-browser'
package 'unzip'

ARCHIVE="chromedriver_#{arch}.zip"

remote_file "/usr/src/#{ARCHIVE}" do
  source "http://chromedriver.storage.googleapis.com/#{node['selenium']['chromedriver_version']}/#{ARCHIVE}"
  action :create_if_missing
  #notifies :run, resources(:execute => "unpack_chromedriver"), :immediately
end

execute "unpack_chromedriver" do
  command "unzip -o /usr/src/#{ARCHIVE} -d /usr/local/bin"
  action :run
end

file '/usr/local/bin/chromedriver' do
  action :touch
  mode 0755
  owner node['selenium']['user']
  group node['selenium']['user']
end
