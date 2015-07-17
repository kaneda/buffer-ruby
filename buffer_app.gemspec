lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'buffer_app/version'

Gem::Specification.new do |s|
  s.name        = 'buffer-app'
  s.version     = BufferApp::VERSION
  s.date        = '2015-07-16'
  s.homepage    = "https://jbegleiter.com"
  s.summary     = "Buffer Gem"
  s.description = "Buffer Gem"
  s.authors     = ["Josh Begleiter"]
  s.email       = 'kanedasan@gmail.com'
  s.license     = 'MIT'
  s.files       = Dir["{lib,vendor}/**/*"] + ["LICENSE.txt","readme.md"]
  s.test_files  = Dir["test/**/*"]

  s.add_dependency 'rails', '>= 4.1.1'
  s.add_dependency 'activemodel', '>= 4.1.1'
  s.add_dependency 'activerecord', '>= 4.1.1'

  s.add_development_dependency 'rspec-rails', '>=2.14.2'
  s.add_development_dependency 'rspec-steps'
  s.add_development_dependency 'webmock', '~> 1.18.0'
  s.add_development_dependency 'factory_girl', '~> 4.0'
end
