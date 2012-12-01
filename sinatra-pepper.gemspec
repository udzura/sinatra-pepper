# -*- encoding: utf-8 -*-
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'sinatra/pepper/version'

Gem::Specification.new do |gem|
  gem.name          = "sinatra-pepper"
  gem.version       = Sinatra::Pepper::VERSION
  gem.authors       = ["Uchio KONDO"]
  gem.email         = ["udzura@udzura.jp"]
  gem.description   = %q{A gem for loading sinatra extensions by condition, like chanko or chili gem for sinatra}
  gem.summary       = %q{A gem for loading sinatra extensions by condition, like chanko or chili gem for sinatra}
  gem.homepage      = "https://github.com/udzura/sinatra-pepper"

  gem.files         = `git ls-files`.split($/)
  # gem.executables   = gem.files.grep(%r{^bin/}).map{ |f| File.basename(f) }
  gem.test_files    = gem.files.grep(%r{^(spec|features)/})
  gem.require_paths = ["lib"]

  gem.add_dependency 'sinatra', '>= 1.3.0'
  gem.add_development_dependency 'rspec', '>= 0'
  gem.add_development_dependency 'rack-test', '>= 0'
  gem.add_development_dependency 'pry', '>= 0'
end
