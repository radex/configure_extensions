# -*- encoding: utf-8 -*-
$:.unshift File.expand_path('../lib', __FILE__)

require 'configure_extensions/version'

Gem::Specification.new do |s|
  s.name        = 'configure_extensions'
  s.license     = 'MIT'
  s.authors     = ['Radek Pietruszewski']
  s.email       = 'this.is@radex.io'
  s.homepage    = 'https://github.com/radex/configure_extensions'
  s.version     = ConfigureExtensions::VERSION
  s.platform    = Gem::Platform::RUBY
  s.summary     = "Add and remove app extensions from Xcode build"
  s.description = "CLI tool that allows you to enable/disable app extensions from being built and embedded into your app. Use to maintain compatibility between two SDK versions or for a fast build mode."

  s.files         = Dir['lib/**/*'] + %w(bin/configure_extensions README.md LICENSE)
  
  s.executables   = s.files.grep(%r{^bin/}) { |f| File.basename(f) }
  s.require_paths = ['lib']

  ## Version 5 needs Ruby 2.2, so we specify an upper bound to stay compatible with system ruby
  s.add_dependency 'activesupport', '>= 4.0.2', '< 5'
  s.add_dependency 'xcodeproj', '~> 1.2'

  s.add_development_dependency 'rake'
end
