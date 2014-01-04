# -*- encoding: utf-8 -*-
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'geocoder_jp/version'

Gem::Specification.new do |gem|
  gem.name          = "geocoder_jp"
  gem.version       = GeocoderJP::VERSION
  gem.authors       = ["yukinoraru"]
  gem.email         = ["yukinoraru@gmail.com"]
  gem.description   = %q{Geocoding.jp API client for Ruby}
  gem.summary       = %q{Geocoding.jp API client for Ruby}
  gem.homepage      = "https://github.com/yukinoraru/geocoder_jp"

  gem.files         = `git ls-files`.split($/)
  gem.executables   = gem.files.grep(%r{^bin/}).map{ |f| File.basename(f) }
  gem.test_files    = gem.files.grep(%r{^(test|spec|features)/})
  gem.require_paths = ["lib"]

  # describe dpendency
  #gem.add_dependency "activesupport", "~>3.2.8"
end
