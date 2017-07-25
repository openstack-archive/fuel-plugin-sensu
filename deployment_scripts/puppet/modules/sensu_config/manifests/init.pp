class sensu_config {
$plugin_name = 'fuel-plugin-sensu'
$fuel_plugin_sensu = hiera($plugin_name, undef)

  notice('MODULAR: fuel-plugin-sensu/sensu_config.pp')
  $influx_port = '8089'
  $redis_vip  = hiera('redis_vip')
  $sensu_vhost = hiera('sensu_vhost')
  $sensu_userid = hiera('sensu_userid')
  $sensu_rabbit_pass = hiera('sensu_rabbit_pass')
  $rabbitmq_vip = $fuel_plugin_sensu['rabbitmq_vip']
    file_line {"changing redis binding":
        path => '/etc/redis/redis.conf',
        line => "bind $ipaddress_br_mgmt",
        match => '^bind .*',
    } 
    file { 'sensu plugins':
      path    => "/opt/sensu/embedded",
      source  => "puppet:///modules/sensu_config/embedded",
      recurse => true,
    }
    file { 'mutator copy':
      path => '/etc/sensu/extensions/mutator-influxdb-line-protocol.rb',
      source => "puppet:///modules/sensu_config/embedded/bin/mutator-influxdb-line-protocol.rb",
    }
  $handlers = inline_template ('
  {
    "handlers": {
      "influxdb_udp": {
        "type": "udp",
        "socket": {
          "host": "<%= @ipaddress_br_mgmt%>",
          "port": <%= @influx_port%>
        },
        "mutator": "influxdb_line_protocol"
      }
    }
  }
  ')
  $config = inline_template ('
  {
    "redis": {
      "host": "<%= @redis_vip%>"
    },
    "transport": {
      "name": "rabbitmq"
    },
    "api": {
      "host": "<%= @redis_vip%>",
      "port": 4568
    }
  }
  ')
  $rabbitmq = inline_template ('
  {
    "rabbitmq": {
      "host": "<%= @rabbitmq_vip%>",
      "port": 5673,
      "vhost": "/<%= @sensu_vhost%>",
      "user": "<%= @sensu_userid%>",
      "password": "<%= @sensu_rabbit_pass%>"
    }
  }
  ')
  file {"rabbitmq.json":
     path => '/etc/sensu/conf.d/rabbitmq.json',
     content => $rabbitmq,
  }
  file {"config.json":
     path => '/etc/sensu/conf.d/config.json',
     content => $config,
  }
  file {"handlers.json":
     path => '/etc/sensu/conf.d/handlers.json',
     content => $handlers,
  }
  service{"sensu-server":
      ensure => running,
      enable => true,
      subscribe => [File['sensu plugins'],File['mutator copy'],File['handlers.json'],File['config.json'],File['rabbitmq.json']],
  }
  service{"sensu-api":
      ensure => running,
      enable => true,
      subscribe => [File['sensu plugins'],File['mutator copy'],File['handlers.json'],File['config.json'],File['rabbitmq.json']],
  }
  service{"sensu-client":
      ensure => running,
      enable => true,
      subscribe => [File['sensu plugins'],File['mutator copy'],File['handlers.json'],File['config.json'],File['rabbitmq.json']],
  }
  service{"redis-server":
      ensure => running,
      enable => true,
      subscribe => [File_line['changing redis binding'],File['sensu plugins'],File['mutator copy'],File['handlers.json'],File['config.json'],File['rabbitmq.json']],
  }
}
class redis_sentinel_config {
  $mgmt= $ipaddress_br_mgmt
  $redis_vip  = hiera('redis_vip')

  file { '/etc/init.d/redis-sentinel':
        content => template('sensu_config/redis-sentinel.erb'),
        mode => '0755',
        notify => Service['redis-sentinel'],
  }
  file { '/etc/redis/sentinel.conf':
        content => template('sensu_config/sentinel.conf.erb'),
        notify => Service['redis-sentinel'],
  }

  service {"redis-sentinel":
        enable => true,
        ensure => running,
  }
}
