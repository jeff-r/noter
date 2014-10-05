# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'noter/version'

Gem::Specification.new do |spec|
  spec.name          = "noter"
  spec.version       = Noter::VERSION
  spec.authors       = ["Jeff Roush"]
  spec.email         = ["jeff@jeffroush.com"]
  spec.summary       = %q{Creates timestamped notes.}
  spec.description   = %q{Inspired (read: stolen) from the 'journal' and 'jrnl' python progrsm. At the moment, those are more developed; use them instead of this.}
  spec.homepage      = "https://github.com/jeff-r/noter"
  spec.license       = "MIT"

  spec.files         = `git ls-files`.split($/)
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.5"
  spec.add_development_dependency "rake", "~> 10.3"
  spec.add_development_dependency "rspec", "~> 3.1"
  spec.add_development_dependency "timecop", "~> 0.7"
  spec.add_development_dependency "fakefs", "~> 0.5"
  spec.add_development_dependency "pry", "~> 0.10"
  spec.add_development_dependency "pry-nav", "~> 0.2"
  spec.add_dependency "pager", "~> 1.0"
  spec.add_dependency "colorize"
end
