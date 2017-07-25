$plugin_hash      = hiera('fuel-plugin-sensu')

if $plugin_hash {

        class { 'sensu_config': }

}

