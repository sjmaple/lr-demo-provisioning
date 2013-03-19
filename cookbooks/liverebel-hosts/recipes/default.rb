hostsfile_entry "#{node["hosts"]["host"]}" do
  hostname  'host.answers.liverebel.com'
  action    :create
end

hostsfile_entry "#{node["hosts"]["java"]}" do
  hostname  'java.answers.liverebel.com'
  action    :create
end
hostsfile_entry "#{node["hosts"]["java1"]}" do
  hostname  'java1.answers.liverebel.com'
  action    :create
end
hostsfile_entry "#{node["hosts"]["java2"]}" do
  hostname  'java2.answers.liverebel.com'
  action    :create
end
hostsfile_entry "#{node["hosts"]["php"]}" do
  hostname  'php.answers.liverebel.com'
  action    :create
end
hostsfile_entry "#{node["hosts"]["php1"]}" do
  hostname  'php1.answers.liverebel.com'
  action    :create
end
hostsfile_entry "#{node["hosts"]["php2"]}" do
  hostname  'php2.answers.liverebel.com'
  action    :create
end