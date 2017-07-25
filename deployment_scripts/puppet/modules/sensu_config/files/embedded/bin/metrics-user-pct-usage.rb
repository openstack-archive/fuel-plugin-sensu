#!/opt/sensu/embedded/bin/ruby
#
# This file was generated by RubyGems.
#
# The application 'sensu-plugins-cpu-checks' is installed as part of a gem, and
# this file is here to facilitate running it.
#

require 'rubygems'

version = ">= 0.a"

if ARGV.first
  str = ARGV.first
  str = str.dup.force_encoding("BINARY") if str.respond_to? :force_encoding
  if str =~ /\A_(.*)_\z/ and Gem::Version.correct?($1) then
    version = $1
    ARGV.shift
  end
end

load Gem.activate_bin_path('sensu-plugins-cpu-checks', 'metrics-user-pct-usage.rb', version)
