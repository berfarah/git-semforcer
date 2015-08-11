# coding: utf-8

Gem::Specification.new do |spec|
  spec.name          = "git-semforcer"
  spec.version       = "1.0.0"
  spec.executables   = %w(git-semforcer)
  spec.require_paths = ["lib"]

  spec.add_dependency "semver", "~> 1.0"
  spec.add_dependency "thor", "~> 0.19"
  spec.add_development_dependency "bundler", "~> 1.10"

  spec.summary       = "A small gem to enforce semver versioning before commits"
  spec.description   = "A tool that generates a pre-commit hook to enforce "\
                       "updated sematic versioning for each commit."

  spec.authors       = ["Bernardo Farah"]
  spec.email         = ["ber@bernardo.me"]
  spec.homepage      = "https://github.com/berfarah/git-semforcer"
  spec.license       = "MIT"

  spec.files         = Dir["{bin,lib,spec}/**/*", "README*", "LICENSE*"]
end
