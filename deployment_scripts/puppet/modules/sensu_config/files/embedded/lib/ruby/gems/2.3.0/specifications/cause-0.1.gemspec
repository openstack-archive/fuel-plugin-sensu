# -*- encoding: utf-8 -*-
# stub: cause 0.1 ruby lib

Gem::Specification.new do |s|
  s.name = "cause".freeze
  s.version = "0.1"

  s.required_rubygems_version = Gem::Requirement.new(">= 0".freeze) if s.respond_to? :required_rubygems_version=
  s.require_paths = ["lib".freeze]
  s.authors = ["Conrad Irwin".freeze]
  s.date = "2013-12-27"
  s.description = "Allows you access to the error that was being handled when this exception was raised.".freeze
  s.email = ["conrad@bugsnag.com".freeze]
  s.homepage = "http://github.com/ConradIrwin/cause".freeze
  s.licenses = ["MIT".freeze]
  s.required_ruby_version = Gem::Requirement.new(">= 1.8.7".freeze)
  s.rubygems_version = "2.6.7".freeze
  s.summary = "A backport of Exception#cause from Ruby 2.1.0".freeze

  s.installed_by_version = "2.6.7" if s.respond_to? :installed_by_version
end
