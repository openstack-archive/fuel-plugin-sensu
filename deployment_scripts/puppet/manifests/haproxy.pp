$plugin_name = 'fuel-plugin-sensu'
$fuel_plugin_sensu = hiera($plugin_name, undef)

if ($fuel_plugin_sensu) {

  notice('fuel-plugin-sensu: haproxy.pp')
  $plugin_hash      = hiera('fuel-plugin-sensu')
  $rabbitmq_vip = $plugin_hash['rabbitmq_vip']
  $redis_vip = $plugin_hash['redis_vip']
  $amqp_port              = 5673
  $nodes_ips = hiera('sensu_nodes')
  $nodes_names = prefix(range(1, size($nodes_ips)), 'amqp_server_')
  
  Openstack::Ha::Haproxy_service {
    internal_virtual_ip  => $internal_virtual_ip,
    server_names        => $nodes_names,
    ipaddresses         => $ipaddresses,
    public              => false,
    public_ssl          => false,
    internal            => true,
  }
  
  openstack::ha::haproxy_service { 'rabbitmq':
    order                  => '180',
    listen_port            => $amqp_port,
    ipaddresses         => $nodes_ips,
    internal_virtual_ip  => $rabbitmq_vip,
    balancermember_port    => $amqp_port,
    balancermember_options => 'check inter 5000 rise 2 fall 3',
    haproxy_config_options => {
      'option'  => ['tcpka'],
      'balance' => 'roundrobin',
      'mode'    => 'tcp',
    }
  }
  openstack::ha::haproxy_service { 'redis':
    order                  => '181',
    listen_port            => 6379,
    internal_virtual_ip  => $redis_vip,
    ipaddresses         => $nodes_ips,
    balancermember_port    => 6379,
    balancermember_options => 'check inter 1s',
    haproxy_config_options => {
      'mode'    => 'tcp',
    }
  }
}
