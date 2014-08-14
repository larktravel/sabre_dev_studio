# -*- encoding: utf-8 -*-
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'sabre_dev_studio/version'

Gem::Specification.new do |gem|
  gem.name          = "sabre_dev_studio"
  gem.version       = SabreDevStudio::VERSION
  gem.authors       = ["Barrett Clark"]
  gem.email         = ["barrett.clark@sabre.com"]
  gem.description   = %q{Sabre Travel Platform Services (TPS) Dev Studio Base Gem}
  gem.summary       = %q{Base gem for Sabre Dev Studio API wrappers}
  gem.homepage      = "http://developer.sabre.com"

  gem.files         = `git ls-files`.split($/)
  gem.executables   = gem.files.grep(%r{^bin/}).map{ |f| File.basename(f) }
  gem.test_files    = gem.files.grep(%r{^(test|spec|features)/})
  gem.require_paths = ["lib"]

  gem.add_development_dependency 'webmock', '~> 1.18.0'
  gem.add_development_dependency 'geminabox', '~> 0.12.4'
  gem.add_development_dependency 'rdoc', '~> 4.1.1'
  gem.add_development_dependency 'rake', '~> 10.1.0'
  gem.add_runtime_dependency 'multi_json', '~> 1.10.1'
  gem.add_runtime_dependency 'httparty', '~> 0.13.1'
  gem.add_runtime_dependency 'hashie', '~> 3.2.0'
end
