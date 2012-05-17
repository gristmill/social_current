# -*- encoding: utf-8 -*-
require File.expand_path('../lib/social_current/version', __FILE__)

Gem::Specification.new do |gem|
  gem.authors       = ["Tristan O'Neil"]
  gem.email         = ["tristanoneil@gmail.com"]
  gem.description   = %q{Makes it easy to integrate a social activity stream into your application from third party APIs.}
  gem.summary       = %q{Makes it easy to integrate a social activity stream into your application from third party APIs.}

  gem.files         = `git ls-files`.split($\)
  gem.executables   = gem.files.grep(%r{^bin/}).map{ |f| File.basename(f) }
  gem.test_files    = gem.files.grep(%r{^(test|spec|features)/})
  gem.name          = "social_current"
  gem.require_paths = ["lib"]
  gem.version       = SocialCurrent::VERSION

  gem.add_runtime_dependency     "httparty", "~> 0.8.3"
  gem.add_development_dependency "fakeweb", "~> 1.3.0"
end
