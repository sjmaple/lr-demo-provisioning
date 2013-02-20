This is grid2 setup cookbook

# Usage
To setup Hub use runlist as:

"recipe[selenium::grid_hub]"

To setup Node use runlist as:

"recipe[selenium::firefox]", "recipe[selenium::chrome]", "recipe[selenium::grid_node]"

Ensure selenium.node.hubhost overriden to hub-host

To setup Hub-Node use runlist as:

"recipe[selenium::firefox]", "recipe[selenium::chrome]", "recipe[selenium::grid_hub]", "recipe[selenium::grid_node]", 

Note:
* Default hub port is 4444.
* Default node DISPLAY is :98.

# Requires
* java reciepe - for node, hub
* python - for local debug

# Limitation/Todo
WebDriver focus, legacy is turned off.

Only linux support (not fully tested) for Firefox and Chrome.

IE and other capabilities should be connected from other nodes.