Set up the demo environment
===========================

* download and install LiveRebel: http://zeroturnaround.com/liverebel
* download and install Oracle VirtualBox: https://www.virtualbox.org
* download and install Vagrant : http://www.vagrantup.com

* note that when using Vagrant 1.0.6 on Windows with Cygwin, there's a known bug
  regarding Unix type paths and Windows paths. This forum posts gives an easy
  fix that can be used until a new version of Vagrant is released:
  https://groups.google.com/forum/#!msg/vagrant-up/UEixJVaHYMw/cmMHmLxLxGEJ

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

* if you want to use the Facebook login feature of the demo applications, you
  will need to add the following entries to your local host name database,
  on Unix-based systems you can simply add these lines to the /etc/hosts file
  of the machine on which you're using the web browser:

    ```
    10.127.128.1 host.answers.liverebel.com
    10.127.128.2 java.answers.liverebel.com
    10.127.128.3 java1.answers.liverebel.com
    10.127.128.4 java2.answers.liverebel.com
    10.127.128.5 php.answers.liverebel.com
    10.127.128.6 php1.answers.liverebel.com
    10.127.128.7 php2.answers.liverebel.com
    ```

Start a PHP cluster
-------------------

* in another terminal start the virtual machines, note that this takes a long
  time since Chef will run the provisioning scripts on each virtual machine
  and download the software that needs to be installed,
  make sure the `lr-demo-provisioning` directory is your current directory:

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
    not be able to deploy unless you provide suitable values, below are
    a few example properties that will make the demo application work but
    they need fine-tuning for the mail and Facebook sections:

    ```
    db.url=mysql:host=10.127.128.5;dbname=qa
    db.username=qa
    db.password=change_me
    fb.appId=12345678901234
    fb.appSecret=123456789012a1234567890b12234567
    mail.host=smtp.gmail.com
    mail.username=you@gmail.com
    mail.password=yourpassword
    mail.port=587
    mail.encryption=tls
    ```

  * when the deployment is done, visit the following URL to see the
    application running through the load balancer:

    ```
    http://10.127.128.5
    ```

  * if you set up the hosts database entries, you can visit the following
    address instead and will be able to use the Facebook login feature:

    ```
    http://php.answers.liverebel.com
    ```

Start a Tomcat cluster
----------------------

* in another terminal start the virtual machines, note that this takes a long
  time since Chef will run the provisioning scripts on each virtual machine
  and download the software that needs to be installed,
  make sure the `lr-demo-provisioning` directory is your current directory:

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

* now you can deploy the `lr-demo-answers-java` web application through
  LiveRebel in both configured Tomcat servers and the database server, these
  are the steps:

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
    not be able to deploy unless you provide suitable values, below are
    a few example properties that will make the demo application work but
    they need fine-tuning for the mail and Facebook sections:

    ```
    db.url=jdbc:mysql://10.127.128.2:3306/qa
    db.username=qa
    db.password=change_me
    fb.appId=12345678901234
    fb.appSecret=123456789012a1234567890b12234567
    mail.host=smtp.gmail.com
    mail.username=you@gmail.com
    mail.password=yourpassword
    mail.port=587
    mail.authenticate=true
    mail.protocol=smtps
    mail.startttls=true
    ```

  * when the deployment is done, visit the following URL to see the
    application running through the load balancer:

    ```
    http://10.127.128.2/lr-demo-answers-java
    ```

  * if you set up the hosts database entries, you can visit the following
    address instead and will be able to use the Facebook login feature:

    ```
    http://java.answers.liverebel.com/lr-demo-answers-java
    ```


Start a composite cluster
----------------------

* in a terminal start the virtual machines, note that this takes a long
  time since Chef will run the provisioning scripts on each virtual machine
  and download the software that needs to be installed,
  make sure the `lr-demo-provisioning` directory is your current directory:

    ```bash
    $ vagrant up compositecluster composite1 composite2
    ```

* you have to add the following entries to your local host name database
  on Unix-based systems you can simply add these lines to the /etc/hosts file
  of the machine on which you're using the web browser:

    ```
    10.127.128.8 java.answers.liverebel.com php.answers.liverebel.com
    10.127.128.9 composite1.answers.liverebel.com
    10.127.128.10 composite2.answers.liverebel.com
    ```

* note that the first host entry above is conflicting with the following
  entries that you might have added when following the instructions at the top
  of this document, you'll have to **remove these entries**:

    ```
    10.127.128.2 java.answers.liverebel.com
    10.127.128.5 php.answers.liverebel.com
    ```

* try the different nodes out in a web browser:

    ```
    http://java.answers.liverebel.com/balancer-manager (overview of the Java load balancer)
    http://php.answers.liverebel.com/balancer-manager (overview of the PHP load balancer)
    http://10.127.128.9:8080 (default Tomcat web app of node composite1)
    http://10.127.128.10:8080 (default Tomcat web app of node composite2)
    http://10.127.128.9 (default Apache web app of node composite1)
    http://10.127.128.10 (default Apache web app of node composite2)
    ```

* all the nodes automatically download the latest file agent from LiveRebel
  running on your machine outside of Vagrant and start it, you should see two
  file servers, to application servers and one database server in the
  LiveRebel Command Center at:

    ```
    https://localhost:9001
    ```

* the Tomcat service init scripts have also been modified to use the installed
  LiveRebel agent

* now you can deploy the `lr-demo-answers-java` web application through
  LiveRebel in both configured Tomcat servers and the database server, these
  are the steps:

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
    Host: 10.127.128.8 : 3306 / 
    Username: qa  Password: change_me
    ```
  
  * go to the LiveRebel `Applications` tab and press the `Add Application`
    button to upload the four .war versions of the Java Answers demo
    application

  * when the upload is finished, click the `Add Deployment` button to select
    which version you want to deploy (start with v1.0 and upgrade through
    the next versions later on)

  * some application properties will not be known by LiveRebel and you will
    not be able to deploy unless you provide suitable values, below are
    a few example properties that will make the demo application work but
    they need fine-tuning for the mail and Facebook sections:

    ```
    db.url=jdbc:mysql://10.127.128.2:3306/qa
    db.username=qa
    db.password=change_me
    fb.appId=12345678901234
    fb.appSecret=123456789012a1234567890b12234567
    mail.host=smtp.gmail.com
    mail.username=you@gmail.com
    mail.password=yourpassword
    mail.port=587
    mail.authenticate=true
    mail.protocol=smtps
    mail.startttls=true
    ```

  * when the deployment is done, visit the following URL to see the
    application running through the load balancer:

    ```
    http://10.127.128.2/lr-demo-answers-java
    ```

  * if you set up the hosts database entries, you can visit the following
    address instead and will be able to use the Facebook login feature:

    ```
    http://java.answers.liverebel.com/lr-demo-answers-java
    ```


Remarks about the provided files
================================

* the Vagrantfile is the entry point towards the setup of this demo environment

  - make sure that the configured IP addresses aren't conflicting with hosts on
    your local network, if they are, the easiest way to change them if by
    selecting another value for the global `lr_subnet` variable. By default it
    is set to `10.127.128`

  - if you change the configured IP addresses, make sure to also adapt the
    entries in your local hosts database in case you added the mappings that
    were shown at the beginning of the readme

  - your own machine is communicating through a dedicated host-only network with
    the Vagrant nodes, the IP address of your machine is `10.127.128.1`

  - MySQL is set up with `change_me` for its passwords, you might want
    to ... change them :-)

* the Chef cookbooks prefixed with `liverebel-` have been created or modified
  specifically for this demo environment

* all the other Chef cookbooks are the standard ones that can be obtained from
  http://community.opscode.com/cookbooks
