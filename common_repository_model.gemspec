# -*- encoding: utf-8 -*-
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'common_repository_model/version'

Gem::Specification.new do |gem|
  gem.name          = "common_repository_model"
  gem.version       = CommonRepositoryModel::VERSION
  gem.authors       = [
    "Jeremy Friesen"
  ]
  gem.email         = [
    "jeremy.n.friesen@gmail.com"
  ]
  gem.description   = %q{Notre Dame's Common Fedora Repository Model}
  gem.summary       = %q{Notre Dame's Common Fedora Repository Model}
  gem.homepage      = "https://github.com/ndlib/common_repository_model"

  gem.files         = `git ls-files`.split($/)
  gem.executables   = gem.files.grep(%r{^bin/}).map{ |f| File.basename(f) }
  gem.test_files    = gem.files.grep(%r{^(test|spec|features)/})
  gem.require_paths = ["lib"]

  gem.add_dependency "activesupport", "~>3.2.11"
  gem.add_dependency "activemodel", "~>3.2.11"
  gem.add_dependency "builder", "~>3.0"
  gem.add_dependency "active_model_serializers"
  gem.add_dependency "active-fedora", "~>5.6.1"
  gem.add_dependency "equivalent-xml"
  gem.add_dependency "morphine", "~> 0.1.1"
  gem.add_development_dependency "minitest"
  gem.add_development_dependency "minitest-matchers"
  gem.add_development_dependency "factory_girl"
end
