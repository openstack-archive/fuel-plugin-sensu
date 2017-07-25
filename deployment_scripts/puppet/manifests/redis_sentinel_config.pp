$plugin_hash      = hiera('fuel-plugin-sensu')

if $plugin_hash {

        class { 'redis_sentinel_config': }

}

