node['selenium']['bindings'].each do |lang,ver|
  case lang
  when 'python'
    include_recipe 'python'

    python_pip 'selenium' do
      version ver
      action :install
    end
  when 'ruby'
    package "build-essential"
    gem_package 'selenium-webdriver' do
      version ver
      action :install
    end
  end
end
