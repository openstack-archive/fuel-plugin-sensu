$plugin_name = 'fuel-plugin-sensu'
$fuel_plugin_sensu = hiera($plugin_name, undef)

if ($fuel_plugin_sensu) {

  notice('fuel-plugin-sensu: redis_haproxy.pp')
  $plugin_hash      = hiera('fuel-plugin-sensu')
  $redis_vip = $plugin_hash['redis_vip']
  $nodes_ips = hiera('sensu_nodes')
  
  Openstack::Ha::Haproxy_service {
    internal_virtual_ip  => $internal_virtual_ip,
    server_names        => $nodes_names,
    ipaddresses         => $ipaddresses,
    public              => false,
    public_ssl          => false,
    internal            => true,
  }
  
  $redis_conf = inline_template('
defaults REDIS
mode tcp
timeout connect 3s
timeout server 6s
timeout client 6s

# Specifies listening socket for accepting client connections using the default
# REDIS TCP timeout and backend bk_redis TCP health check.
frontend ft_redis
bind <%= @redis_vip%>:6379 name redis
default_backend bk_redis

# Specifies the backend Redis proxy server TCP health settings
# Ensure it only forward incoming connections to reach a master.
backend bk_redis
option tcp-check
tcp-check connect
tcp-check send PING\r\n
tcp-check expect string +PONG
tcp-check send info\ replication\r\n
tcp-check expect string role:master
tcp-check send QUIT\r\n
tcp-check expect string +OK
mode  tcp
<% @nodes_ips.each_with_index.map do |v,i| -%>
server server_<%= i+1 %> <%= v %>:6379   check inter 1s
<% end -%>
')
  file{"redis haproxy":
       ensure => present,
       path => "/etc/haproxy/conf.d/181-redis.cfg",
       content => $redis_conf,
       notify => Exec['haproxy restart'],
  }
  exec {"haproxy restart":
       command => "crm resource restart clone_p_haproxy",
       path => '/usr/sbin/',
  }
}
