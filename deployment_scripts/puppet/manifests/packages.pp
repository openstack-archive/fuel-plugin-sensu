$plugin_name = 'fuel-plugin-sensu'
$fuel_plugin_sensu = hiera($plugin_name, undef)

  $packages = ['sensu','redis-server','curl','jq']

   define pkg_install {
          package {"$name":
             ensure => latest,
          }
  }

if ($fuel_plugin_sensu) {
notice('fuel-plugin-sensu: packages.pp')
pkg_install { $packages: }
}
