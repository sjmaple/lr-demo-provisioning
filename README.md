Set up the demo environment
===========================

* download and install LiveRebel: http://zeroturnaround.com/liverebel
* download and install Oracle VirtualBox: https://www.virtualbox.org
* download and install Vagrant : http://www.vagrantup.com

* download and add the precise32 Vagrant box:

    ```bash
    $ vagrant box add precise32 http://files.vagrantup.com/precise32.box
    ```

* start LiveRebel:

    ```bash
    On Unix    $ ./bin/lr-command-center.sh run
    On Windows $ bin\lr-command-center.cmd run
    ```

* check it's running by open this URL in your browser, keep it open:

    ```
    https://localhost:9001
    ```

* provide a LiveRebel license (free or commercial)

* create your first admin in LiveRebel

* for the next steps it's important that you have no firewall blocking incoming
  http and https traffic to Java applications, otherwise it will not be
  possible to connect from the virtual machines to your local LiveRebel 
  installation

Start a PHP cluster
-------------------

* in another terminal start the virtual machines, note that this takes a long
  time since Chef will run the provisioning scripts on each virtual machine
  and download the software that needs to be installed:

    ```bash
    $ vagrant up phpcluster php1 php2
    ```

* try the different nodes out in a web browser:

    ```
    http://10.127.128.5/balancer-manager (overview of the load balancer)
    http://10.127.128.6 (default Apache web app of node php1)
    http://10.127.128.7 (default Apache web app of node php2)
    ```

* the PHP nodes automatically download the latest file agent from LiveRebel
  running on your machine outside of Vagrant and start it, you should see two
  file servers and one database server in the LiveRebel Command Center at:

    ```
    https://localhost:9001
    ```

* now you can deploy the `lr-demo-answers` PHP application through LiveRebel in
  both configured Apache servers and the database server, these are the steps:

  * install the MySQL JDBC driver for database migrations by going to the
    `Database drivers` section in LiveRebel's `Configuration` panel,
    you can download the driver from here:

    ```
    http://dev.mysql.com/downloads/connector/j/
    ```

  * configure the MySQL server in LiveRebel by going to the `Servers` tab and
    clicking on `Details` next to `Database server`, these are the connection
    details:

    ```
    Driver: MySQL
    Host: 10.127.128.5 : 3306 / qa
    Username: qa  Password: change_me
    ```
  
  * go to the LiveRebel `Applications` tab and press the `Add Application`
    button to upload the four versions of the PHP Answers demo application

  * when the upload is finished, click the `Add Deployment` button to select
    which version you want to deploy (start with v1.0 and upgrade through
    the next versions later on)

  * the deployment path for which the PHP servers are configured
    is `/var/www/lr-demo-answers`, you'll have to enter that in the `Path`
    textfield

  * some application properties will not be known by LiveRebel and you will
    not be able to deploy v1.0 unless you provide suitable values

  * when the deployment is done, visit the following URL to see the
    application running through the load balancer:

    ```
    http://10.127.128.5
    ```

Start a Tomcat cluster
----------------------

* add a new server to LiveRebel by clicking 'add server'

* in another terminal start the virtual machines:

    ```bash
    $ vagrant up tomcatcluster tomcat1 tomcat2
    ```

* try the different nodes out in a web browser:

    ```
    http://10.127.128.2/balancer-manager (overview of the load balancer)
    http://10.127.128.3:8080 (default Tomcat web app of node tomcat1)
    http://10.127.128.4:8080 (default Tomcat web app of node tomcat2)
    ```

* the Tomcat nodes automatically download the latest file agent from LiveRebel
  running on your machine outside of Vagrant and start it, you should see two
  file servers and one database server in the LiveRebel Command Center at:

    ```
    https://localhost:9001
    ```

* the Tomcat service init scripts have also been modified to use the installed
  LiveRebel agent

* now you can deploy the `lr-demo-answers` web application through LiveRebel in
  both configured Tomcat servers and the database server, these are the steps:

  * install the MySQL JDBC driver for database migrations by going to the
    `Database drivers` section in LiveRebel's `Configuration` panel,
    you can download the driver from here:

    ```
    http://dev.mysql.com/downloads/connector/j/
    ```

  * configure the MySQL server in LiveRebel by going to the `Servers` tab and
    clicking on `Details` next to `Database server`, these are the connection
    details:

    ```
    Driver: MySQL
    Host: 10.127.128.2 : 3306 / qa
    Username: qa  Password: change_me
    ```
  
  * go to the LiveRebel `Applications` tab and press the `Add Application`
    button to upload the four .war versions of the Java Answers demo
    application

  * when the upload is finished, click the `Add Deployment` button to select
    which version you want to deploy (start with v1.0 and upgrade through
    the next versions later on)

  * some application properties will not be known by LiveRebel and you will
    not be able to deploy v1.0 unless you provide suitable values

  * when the deployment is done, visit the following URL to see the
    application running through the load balancer:

    ```
    http://10.127.128.2/lr-demo-answers
    ```

Remarks about the provided files
================================

* the Vagrantfile is the entry point towards the setup of this demo environment

  - make sure that the configured IP addresses aren't conflicting with hosts on
    your local network, if they are, the easiest way to change them if by
    selecting another value for the global `lr_subnet` variable. By default it
    is set to `10.127.128`

  - your own machine is communicating through a dedicated host-only network with
    the Vagrant nodes, the IP address of your machine is `10.127.128.1`

  - MySQL is set up with `change_me` for its passwords, you might want
    to ... change them :-)

* the Chef cookbooks prefixed with `liverebel-` have been created or modified
  specifically for this demo environment

* all the other Chef cookbooks are the standard ones that can be obtained from
  http://community.opscode.com/cookbooks