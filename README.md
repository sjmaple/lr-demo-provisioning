Set up the demo environment
===========================

* download and install LiveRebel: http://zeroturnaround.com/liverebel
* download and install Oracle VirtualBox: https://www.virtualbox.org
* download and install Vagrant : http://www.vagrantup.com

* download and add the lucid32 Vagrant box:

		$ vagrant box add lucid32 http://files.vagrantup.com/lucid32.box

* start LiveRebel:

		On Unix    $ ./bin/lr-command-center.sh run
		On Windows $ bin\lr-command-center.cmd run

* check it's running by open this URL in your browser, keep it open:

		https://localhost:9001/

* provide a LiveRebel license (free or commercial)

* create your first admin in LiveRebel

* add a new server to LiveRebel by clicking 'add server'

* in another terminal start the virtual machines:

		$ vagrant up web1
		$ vagrant up web2
		$ vagrant up loadbalancer

* try the different nodes out in a web browser:

		http://10.127.128.2/balancer-manager (overview of the load balancer)
		http://10.127.128.3:8080 (default Tomcat web app of node web1)
		http://10.127.128.4:8080 (default Tomcat web app of node web2)

* set up the `web1` server for LiveRebel:

		$ vagrant ssh web1

		$ sudo su -
		$ service tomcat6 stop

		$ export CATALINA_BASE=/var/lib/tomcat6
		$ export CATALINA_HOME=/usr/share/tomcat6
		$ cd $CATALINA_BASE

		$ wget -O lr-agent-installer.jar --no-check-certificate https://10.127.128.1:9001/public/lr-agent-installer.jar
		$ java -DserverHome=$CATALINA_HOME -jar lr-agent-installer.jar
		$ chown -R tomcat6:tomcat6 lr-agent

* check if the LiveRebel Command Center sees the Tomcat with the agent, however
  use the following shell command to start Tomcat instead of what's shown in
  the Command Center:

		$ su -s /bin/bash -c "$CATALINA_BASE/lr-agent/bin/run.sh $CATALINA_HOME/bin/catalina.sh run" tomcat6

* check the LiveRebel Command Center again and you should see the server status
  changing towards orange and finally green, you can now click the 'finish'
	button

* press `ctrl+c` to interrupt the running Tomcat server

* update the daemon `init.d` script so that the LiveRebel agent is used:

		$ nano -w /etc/init.d/tomcat6

* inside the `catalina_sh` function add `$CATALINA_BASE/lr-agent/bin/run.sh`
  before the `$CATALINA_SH command`, for instance:

		...
		cd \"$CATALINA_BASE\"; \
		\"$CATALINA_BASE/lr-agent/bin/run.sh\" \
		\"$CATALINA_SH\" $@"
		...

* start the tomcat service again:

		$ service tomcat6 start

* repeat these steps for web2, except that you don't need to interact with
  the LiveRebel Command Center anymore, it automatically picks up newly added
	servers

		$ vagrant ssh web2
		...

* now you can deploy the `lr-demo` web application through LiveRebel in both
  configured Tomcat servers

Remarks about the provided files
================================

* the Vagrantfile is the entry point towards the setup of this demo environment

  - make sure that the configured IP addresses (`10.127.128.1`, `10.127.128.2`,
	  `10.127.128.3`, `10.127.128.4`) aren't conflicting with hosts on your local
		network

	- the Tomcat webapp context path is set to `lr-demo`, you will probably want
	  to change that if you base you own installation on these files

	- MySQL is set up with `change_me` for its passwords, you might want
	  to ... change them :-)

* a Tomcat super user is set up through Chef's data bags in the `tomcat_users`
  directory, you'll most certainly want to change the password and the id for
	production use

* the Chef cookbooks prefixed with `liverebel-` have been created specifically
  for this demo environment

* all the other Chef cookbooks are the standard ones that can be obtained from
  http://community.opscode.com/cookbooks

* the `tomcat` cookbook has a small tweak in the `server.xml.erb` template to
  make it possible to pass in a `jvmRoute` attribute to the servlet engine
