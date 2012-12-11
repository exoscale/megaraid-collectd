# -*- encoding: utf-8 -*-
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'megaraid-collectd/version'

Gem::Specification.new do |gem|
  gem.name          = "megaraid-collectd"
  gem.version       = Megaraid::Collectd::VERSION
  gem.authors       = ["Pierre-Yves Ritschard"]
  gem.email         = ["prd@exoscale.ch"]
  gem.description   = %q{collectd exec module to watch megaraid status}
  gem.summary       = %q{graph megaraid status}
  gem.homepage      = "https://github.com/exoscale/megaraid-collectd"

  gem.files         = `git ls-files`.split($/)
  gem.executables   = gem.files.grep(%r{^bin/}).map{ |f| File.basename(f) }
  gem.test_files    = gem.files.grep(%r{^(test|spec|features)/})
  gem.require_paths = ["lib"]
end
