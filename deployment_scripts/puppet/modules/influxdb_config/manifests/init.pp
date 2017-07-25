class influxdb_config {
  notice('MODULAR: fuel-plugin-sensu/influx_config.pp')
  $plugin_name = 'fuel-plugin-sensu'
  $fuel_plugin_sensu = hiera($plugin_name, undef)
  $config = inline_template ('
[[udp]]
  enabled = true
  bind-address = "<%= @ipaddress_br_mgmt %>:8089"
  ')

  file_line {"udp config":
       path => "/etc/influxdb/influxdb.conf",
       line => $config,
       notify => Service['influxdb'],
  }
  service {"influxdb":
       ensure => running,
  }

}
