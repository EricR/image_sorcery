lib = File.expand_path('../lib/', __FILE__)
$:.unshift lib unless $:.include?(lib)

require 'bundler/version'

Gem::Specification.new do |s|
  s.name        = "image_sorcery"
  s.version     = "1.0.1"
  s.platform    = Gem::Platform::RUBY
  s.authors     = ["Eric Rafaloff"]
  s.email       = ["hello@ericrafaloff.com"]
  s.homepage    = "http://github.com/ericr/image_sorcery"
  s.summary     = "A ruby ImageMagick library that doesn't suck."
  s.description = "A ruby ImageMagick library that doesn't suck."
  s.files        = Dir.glob("{lib}/**/*") + %w(README.markdown)
  s.require_path = 'lib'
end
