# start from a clean slate every time
hostsfile_entry "#{node["hosts"]["host"]}" do
  action    :remove
end
hostsfile_entry "#{node["hosts"]["java"]}" do
  action    :remove
end
hostsfile_entry "#{node["hosts"]["java1"]}" do
  action    :remove
end
hostsfile_entry "#{node["hosts"]["java2"]}" do
  action    :remove
end
hostsfile_entry "#{node["hosts"]["php"]}" do
  action    :remove
end
hostsfile_entry "#{node["hosts"]["php1"]}" do
  action    :remove
end
hostsfile_entry "#{node["hosts"]["php2"]}" do
  action    :remove
end
if node["hosts"]["composite1"]
  hostsfile_entry "#{node["hosts"]["composite1"]}" do
    action    :remove
  end
end
if node["hosts"]["composite2"]
  hostsfile_entry "#{node["hosts"]["composite2"]}" do
    action    :remove
  end
end

# add latest versions for the hosts
hostsfile_entry "#{node["hosts"]["host"]}" do
  hostname  'host.answers.liverebel.com'
  action    :append
end
hostsfile_entry "#{node["hosts"]["java"]}" do
  hostname  'java.answers.liverebel.com'
  action    :append
end
hostsfile_entry "#{node["hosts"]["java1"]}" do
  hostname  'java1.answers.liverebel.com'
  action    :append
end
hostsfile_entry "#{node["hosts"]["java2"]}" do
  hostname  'java2.answers.liverebel.com'
  action    :append
end
hostsfile_entry "#{node["hosts"]["php"]}" do
  hostname  'php.answers.liverebel.com'
  action    :append
end
hostsfile_entry "#{node["hosts"]["php1"]}" do
  hostname  'php1.answers.liverebel.com'
  action    :append
end
hostsfile_entry "#{node["hosts"]["php2"]}" do
  hostname  'php2.answers.liverebel.com'
  action    :append
end
if node["hosts"]["composite1"]
  hostsfile_entry "#{node["hosts"]["composite1"]}" do
    hostname  'composite1.answers.liverebel.com'
    action    :append
  end
end
if node["hosts"]["composite2"]
  hostsfile_entry "#{node["hosts"]["composite2"]}" do
    hostname  'composite2.answers.liverebel.com'
    action    :append
  end
end