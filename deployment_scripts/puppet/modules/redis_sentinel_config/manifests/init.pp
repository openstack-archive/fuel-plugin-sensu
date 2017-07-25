class redis_sentinel_config {
  $mgmt= $ipaddress_br_mgmt
  $redis_vip  = hiera('redis_vip')

  file { '/etc/init.d/redis-sentinel':
        content => template('redis_sentinel_config/redis-sentinel.erb'),
        mode => '0755',
        notify => Service['redis-sentinel'],
  }
  file { '/etc/redis/sentinel.conf':
        content => template('redis_sentinel_config/sentinel.conf.erb'),
        notify => Service['redis-sentinel'],
  }

  service {"redis-sentinel":
        enable => true,
        ensure => running,
  }
}
