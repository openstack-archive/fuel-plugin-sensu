$plugin_name = 'fuel-plugin-sensu'
$fuel_plugin_sensu = hiera($plugin_name, undef)

if ($fuel_plugin_sensu) {
  notice('MODULAR: fuel-plugin-sensu/hiera_override.pp')
  $hiera_plugins_dir = '/etc/hiera/plugins'
  $plugin_yaml = "${hiera_plugins_dir}/${plugin_name}.yaml"
  $network_metadata = hiera_hash('network_metadata')
  $sensu_roles = ['influxdb_grafana', 'primary-influxdb_grafana']
  $sensu_nodes = get_nodes_hash_by_roles($network_metadata, $sensu_roles)
  $rabbitmq_vip = $fuel_plugin_sensu['rabbitmq_vip']
  $redis_vip = $fuel_plugin_sensu['redis_vip']
  $sensu_userid = sensu
  $sensu_rabbit_pass = 'h4U19fDyq5Jrv7sZdq43'
  $virtual_host = sensu
  $sensu_address_map = get_node_to_ipaddr_map_by_network_role(
    $sensu_nodes,
    'management'
  )

  $sensu_nodes_ips = values($sensu_address_map)
  $sensu_nodes_names = keys($sensu_address_map)

  $amqp_hosts = $sensu_nodes_ips
  $amqp_port = hiera('amqp_port', '5673')

  case hiera_array('roles', 'none') {
    /influxdb_grafana/: {
      $rabbit_enabled = true
      $corosync_roles = $sensu_roles
      $deploy_vrouter = false
      # Set to true HA
      $corosync_nodes = $sensu_nodes
    }
    default: {
      $rabbit_enabled = false
    }
  }

  $vip_content = inline_template('
    rabbtimq_management_vip:
      ipaddr: <%= @rabbitmq_vip %>
      is_user_defined: false
      namespace: haproxy
      network_role: kibana
      node_roles:
      - influxdb_grafana
      - primary-influxdb_grafana
      vendor_specific: null
    redis_vip:
      ipaddr: <%= @redis_vip %>
      is_user_defined: false
      namespace: haproxy
      network_role: kibana
      node_roles:
      - influxdb_grafana
      - primary-influxdb_grafana
      vendor_specific: null

')
  $calculated_content = inline_template('<%
require "yaml"
sensu_vhost = @virtual_host
sensu_userid = @sensu_userid
sensu_rabbit_pass == @sensu_rabbit_pass
vip__rabbitmq = @rabbitmq_vip
redis_vip = @redis_vip
sensu_nodes = @sensu_nodes_ips
amqp_hosts = @amqp_hosts.map {|x| x + ":" + @amqp_port}.join(",")
data = {
  "sensu_vhost" => sensu_vhost,
  "sensu_userid" => sensu_userid,
  "sensu_rabbit_pass" => sensu_rabbit_pass,
  "vip__rabbitmq" => vip__rabbitmq,
  "redis_vip" => redis_vip,
  "sensu_nodes" => sensu_nodes,
  "amqp_hosts" => amqp_hosts,
  "rabbit" => {
    "enabled" => @rabbit_enabled,
  },
  "deploy_vrouter" => @deploy_vrouter,
}
data["corosync_nodes"] = @corosync_nodes if @corosync_nodes
data["corosync_roles"] = @corosync_roles if @corosync_roles

-%>
<%= YAML.dump(data) %>
')

  file { 'hiera_plugins' :
    ensure => 'directory',
    path   => $hiera_plugins_dir,
  }

  file { 'plugin_yaml' :
    ensure  => 'present',
    path    => $plugin_yaml,
    content => $calculated_content,
  }
  file_line {'append astute content':
    ensure => present,
    path   => '/etc/astute.yaml',
    line   => $vip_content,
    after  => '  vips:',
    match  => '\s+rabbtimq_management_vip:',
    replace => false,
  }
}
