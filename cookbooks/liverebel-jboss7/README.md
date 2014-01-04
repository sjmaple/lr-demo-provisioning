Description
===========

Installs and configures JBoss AS 7.

Requirements
============

Platform:

* Debian, Ubuntu (OpenJDK, Oracle)

The following Opscode cookbooks are dependencies:

* java
* unzip

Attributes
==========

* `node["jboss7"]["port"]` - The network port used by JBoss' HTTP connector, default `8080`.
* `node["jboss7"]["ssl_port"]` - The network port used by JBoss' SSL HTTP connector, default `8443`.
* `node["jboss7"]["ajp_port"]` - The network port used by JBoss' AJP connector, default `8009`.
* `node["jboss7"]["version"]` - The JBoss version, default `7.1.1`.
* `node["jboss7"]["user"]` - JBoss user, default `jboss`.
* `node["jboss7"]["group"]` - JBoss group, default `jboss`.
* `node["jboss7"]["target"]` - The target folder where JBoss is installed, default `/usr/share`.


License
=======

Licensed under the Apache License, Version 2.0 (the "License");
you may not use this file except in compliance with the License.
You may obtain a copy of the License at

    http://www.apache.org/licenses/LICENSE-2.0

Unless required by applicable law or agreed to in writing, software
distributed under the License is distributed on an "AS IS" BASIS,
WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
See the License for the specific language governing permissions and
limitations under the License.