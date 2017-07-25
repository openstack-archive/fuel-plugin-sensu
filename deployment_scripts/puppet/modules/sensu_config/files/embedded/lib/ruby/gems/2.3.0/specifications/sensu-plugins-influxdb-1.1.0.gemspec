# -*- encoding: utf-8 -*-
# stub: sensu-plugins-influxdb 1.1.0 ruby lib

Gem::Specification.new do |s|
  s.name = "sensu-plugins-influxdb".freeze
  s.version = "1.1.0"

  s.required_rubygems_version = Gem::Requirement.new(">= 0".freeze) if s.respond_to? :required_rubygems_version=
  s.metadata = { "development_status" => "active", "maintainer" => "sensu-plugin", "production_status" => "unstable - testing recommended", "release_draft" => "false", "release_prerelease" => "false" } if s.respond_to? :metadata=
  s.require_paths = ["lib".freeze]
  s.authors = ["Sensu-Plugins and contributors".freeze]
  s.date = "2016-12-02"
  s.description = "This plugin provides native InfluxDB instrumentation\n                              for monitoring and metrics collection, including:\n                              service health via `/ping`, running queries, and service\n                              metrics.".freeze
  s.email = "<sensu-users@googlegroups.com>".freeze
  s.executables = ["check-influxdb-query.rb".freeze, "check-influxdb.rb".freeze, "metrics-influxdb.rb".freeze, "mutator-influxdb-line-protocol.rb".freeze]
  s.files = ["bin/check-influxdb-query.rb".freeze, "bin/check-influxdb.rb".freeze, "bin/metrics-influxdb.rb".freeze, "bin/mutator-influxdb-line-protocol.rb".freeze]
  s.homepage = "https://github.com/sensu-plugins/sensu-plugins-influxdb".freeze
  s.licenses = ["MIT".freeze]
  s.post_install_message = "You can use the embedded Ruby by setting EMBEDDED_RUBY=true in /etc/default/sensu".freeze
  s.required_ruby_version = Gem::Requirement.new(">= 2.0.0".freeze)
  s.rubygems_version = "2.6.7".freeze
  s.summary = "Sensu plugins for influxdb".freeze

  s.installed_by_version = "2.6.7" if s.respond_to? :installed_by_version

  if s.respond_to? :specification_version then
    s.specification_version = 4

    if Gem::Version.new(Gem::VERSION) >= Gem::Version.new('1.2.0') then
      s.add_runtime_dependency(%q<dentaku>.freeze, ["= 2.0.9"])
      s.add_runtime_dependency(%q<influxdb>.freeze, ["= 0.3.13"])
      s.add_runtime_dependency(%q<jsonpath>.freeze, ["= 0.5.8"])
      s.add_runtime_dependency(%q<sensu-plugin>.freeze, ["~> 1.3"])
      s.add_development_dependency(%q<bundler>.freeze, ["~> 1.7"])
      s.add_development_dependency(%q<codeclimate-test-reporter>.freeze, ["~> 0.4"])
      s.add_development_dependency(%q<github-markup>.freeze, ["~> 1.3"])
      s.add_development_dependency(%q<pry>.freeze, ["~> 0.10"])
      s.add_development_dependency(%q<rake>.freeze, ["~> 10.0"])
      s.add_development_dependency(%q<redcarpet>.freeze, ["~> 3.2"])
      s.add_development_dependency(%q<rspec>.freeze, ["~> 3.1"])
      s.add_development_dependency(%q<rubocop>.freeze, ["~> 0.40.0"])
      s.add_development_dependency(%q<yard>.freeze, ["~> 0.8"])
    else
      s.add_dependency(%q<dentaku>.freeze, ["= 2.0.9"])
      s.add_dependency(%q<influxdb>.freeze, ["= 0.3.13"])
      s.add_dependency(%q<jsonpath>.freeze, ["= 0.5.8"])
      s.add_dependency(%q<sensu-plugin>.freeze, ["~> 1.3"])
      s.add_dependency(%q<bundler>.freeze, ["~> 1.7"])
      s.add_dependency(%q<codeclimate-test-reporter>.freeze, ["~> 0.4"])
      s.add_dependency(%q<github-markup>.freeze, ["~> 1.3"])
      s.add_dependency(%q<pry>.freeze, ["~> 0.10"])
      s.add_dependency(%q<rake>.freeze, ["~> 10.0"])
      s.add_dependency(%q<redcarpet>.freeze, ["~> 3.2"])
      s.add_dependency(%q<rspec>.freeze, ["~> 3.1"])
      s.add_dependency(%q<rubocop>.freeze, ["~> 0.40.0"])
      s.add_dependency(%q<yard>.freeze, ["~> 0.8"])
    end
  else
    s.add_dependency(%q<dentaku>.freeze, ["= 2.0.9"])
    s.add_dependency(%q<influxdb>.freeze, ["= 0.3.13"])
    s.add_dependency(%q<jsonpath>.freeze, ["= 0.5.8"])
    s.add_dependency(%q<sensu-plugin>.freeze, ["~> 1.3"])
    s.add_dependency(%q<bundler>.freeze, ["~> 1.7"])
    s.add_dependency(%q<codeclimate-test-reporter>.freeze, ["~> 0.4"])
    s.add_dependency(%q<github-markup>.freeze, ["~> 1.3"])
    s.add_dependency(%q<pry>.freeze, ["~> 0.10"])
    s.add_dependency(%q<rake>.freeze, ["~> 10.0"])
    s.add_dependency(%q<redcarpet>.freeze, ["~> 3.2"])
    s.add_dependency(%q<rspec>.freeze, ["~> 3.1"])
    s.add_dependency(%q<rubocop>.freeze, ["~> 0.40.0"])
    s.add_dependency(%q<yard>.freeze, ["~> 0.8"])
  end
end
