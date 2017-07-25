# -*- encoding: utf-8 -*-
# stub: influxdb 0.3.13 ruby lib

Gem::Specification.new do |s|
  s.name = "influxdb".freeze
  s.version = "0.3.13"

  s.required_rubygems_version = Gem::Requirement.new(">= 0".freeze) if s.respond_to? :required_rubygems_version=
  s.require_paths = ["lib".freeze]
  s.authors = ["Todd Persen".freeze]
  s.date = "2016-11-23"
  s.description = "This is the official Ruby library for InfluxDB.".freeze
  s.email = ["influxdb@googlegroups.com".freeze]
  s.homepage = "http://influxdb.org".freeze
  s.licenses = ["MIT".freeze]
  s.rubygems_version = "2.6.7".freeze
  s.summary = "Ruby library for InfluxDB.".freeze

  s.installed_by_version = "2.6.7" if s.respond_to? :installed_by_version

  if s.respond_to? :specification_version then
    s.specification_version = 4

    if Gem::Version.new(Gem::VERSION) >= Gem::Version.new('1.2.0') then
      s.add_runtime_dependency(%q<json>.freeze, [">= 0"])
      s.add_runtime_dependency(%q<cause>.freeze, [">= 0"])
      s.add_development_dependency(%q<rake>.freeze, [">= 0"])
      s.add_development_dependency(%q<bundler>.freeze, ["~> 1.3"])
      s.add_development_dependency(%q<rspec>.freeze, ["~> 3.5.0"])
      s.add_development_dependency(%q<webmock>.freeze, ["~> 2.1.0"])
      s.add_development_dependency(%q<rubocop>.freeze, ["~> 0.41.2"])
    else
      s.add_dependency(%q<json>.freeze, [">= 0"])
      s.add_dependency(%q<cause>.freeze, [">= 0"])
      s.add_dependency(%q<rake>.freeze, [">= 0"])
      s.add_dependency(%q<bundler>.freeze, ["~> 1.3"])
      s.add_dependency(%q<rspec>.freeze, ["~> 3.5.0"])
      s.add_dependency(%q<webmock>.freeze, ["~> 2.1.0"])
      s.add_dependency(%q<rubocop>.freeze, ["~> 0.41.2"])
    end
  else
    s.add_dependency(%q<json>.freeze, [">= 0"])
    s.add_dependency(%q<cause>.freeze, [">= 0"])
    s.add_dependency(%q<rake>.freeze, [">= 0"])
    s.add_dependency(%q<bundler>.freeze, ["~> 1.3"])
    s.add_dependency(%q<rspec>.freeze, ["~> 3.5.0"])
    s.add_dependency(%q<webmock>.freeze, ["~> 2.1.0"])
    s.add_dependency(%q<rubocop>.freeze, ["~> 0.41.2"])
  end
end
