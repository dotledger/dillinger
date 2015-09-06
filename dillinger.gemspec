# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'dillinger/version'

Gem::Specification.new do |spec|
  spec.name          = 'dillinger'
  spec.version       = Dillinger::VERSION
  spec.author        = 'Kale Worsley'
  spec.email         = 'kale@worsley.co.nz'

  spec.summary       = 'Ruby Bank Statement Parsing Library'
  spec.description   = 'Dillinger is a library for detecting and parsing bank statements in Ruby.'
  spec.homepage      = 'https://github.com/dotledger/dillinger'
  spec.license       = 'MIT'

  spec.platform      = Gem::Platform::RUBY
  spec.files         = Dir['lib/**/*.rb']
  spec.test_files    = Dir['spec/**/*.rb']
  spec.require_paths = ['lib']

  spec.add_development_dependency 'bundler', '~> 1.9'
  spec.add_development_dependency 'rake', '~> 10.0'
  spec.add_development_dependency 'rspec', '~> 3.2'

  spec.add_runtime_dependency 'activemodel', '~> 4.2'
  spec.add_runtime_dependency 'ofx'
  spec.add_runtime_dependency 'qif'
end
