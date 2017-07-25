$plugin_name = 'fuel-plugin-sensu'
$fuel_plugin_sensu = hiera($plugin_name, undef)

if ($fuel_plugin_sensu) {

  notice('MODULAR: fuel-plugin-sensu/rabbitmq_sensu.pp')
  $sensu_vhost = hiera('sensu_vhost')
  $sensu_userid = hiera('sensu_userid')
  $sensu_rabbit_pass = hiera('sensu_rabbit_pass')
  
  rabbitmq_vhost { $sensu_vhost:
     provider => 'rabbitmqctl',
  }->
  rabbitmq_user { $sensu_userid:
     admin    => true,
     password => $sensu_rabbit_pass,
     provider => 'rabbitmqctl',
  }->
  rabbitmq_user_permissions { "${sensu_userid}@${sensu_vhost}":
     configure_permission => '.*',
     write_permission     => '.*',
     read_permission      => '.*',
     provider             => 'rabbitmqctl',
  }
}
