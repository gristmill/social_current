# -*- encoding: utf-8 -*-
require File.expand_path('../lib/github_activity/version', __FILE__)

Gem::Specification.new do |gem|
  gem.authors       = ["Tristan O'Neil"]
  gem.email         = ["tristanoneil@gmail.com"]
  gem.description   = %q{Makes it easy to integrate the Github activity stream into your application.}
  gem.summary       = %q{Makes it easy to integrate the Github activity stream into your application.}

  gem.files         = `git ls-files`.split($\)
  gem.executables   = gem.files.grep(%r{^bin/}).map{ |f| File.basename(f) }
  gem.test_files    = gem.files.grep(%r{^(test|spec|features)/})
  gem.name          = "github_activity"
  gem.require_paths = ["lib"]
  gem.version       = GithubActivity::VERSION

  gem.add_runtime_dependency     "httparty", "~> 0.8.3"
  gem.add_development_dependency "fakeweb", "~> 1.3.0"
end
