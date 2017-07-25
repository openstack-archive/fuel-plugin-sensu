Sensu plugin for Fuel
=================================

Overview
--------

Sensu plugin for Fuel extends Mirantis OpenStack functionality by adding
Sensu monitoring. It can be deployed on hosts with Stacklight plugins roles.
Sensu plugin is 100% hot-pluggable.


Compatible Fuel versions
------------------------

9.0


User Guide
----------

1. Create an environment or open existing. In case of new environment select new nodes
   with LMA Stacklights roles
2. Enable the plugin on the Settings/Other tab of the Fuel web UI and fill in form
    fields:
   * in development

3. Deploy the environment.


Installation Guide
==================

Sensu Plugin for Fuel installation
----------------------------------------------

To install Sensu plugin, follow these steps:

1. Download the plugin
    git clone https://github.com/openstack/fuel-plugin-sensu

2. Copy the plugin on already installed Fuel Master node; ssh can be used for
    that. If you do not have the Fuel Master node yet, see
    [Quick Start Guide](https://software.mirantis.com/quick-start/):

        # scp fuel-plugin-sensu-0.1.1-1.noarch.rpm root@<Fuel_master_ip>:/tmp

3. Log into the Fuel Master node. Install the plugin:

        # cd /tmp
        # fuel plugins --install fuel-plugin-sensu-0.1.1-1.noarch.rpm

4. Check if the plugin was installed successfully:

        # fuel plugins
        id | name                            | version | package_version
        ---|---------------------------------|---------|----------------
        1  | fuel-plugin-sensu   | 0.1.1  | 4.0.0


Requirements
------------

| Requirement                      | Version/Comment |
|:---------------------------------|:----------------|
| Mirantis OpenStack compatibility | 9.0             |


Limitations
-----------

This plugin can be used only with Stacklight LMA nodes
