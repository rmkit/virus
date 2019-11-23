lib = File.expand_path("lib", __dir__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require "virus/version"

Gem::Specification.new do |spec|
  spec.name          = "virus"
  spec.version       = Virus::VERSION
  spec.authors       = ["xiongzenghui"]
  spec.email         = ["zxcvb1234001@163.com"]

  spec.summary       = %q{this is a CocoaPods simple wrapper}
  spec.description   = %q{this is a CocoaPods simple wrapper}
  spec.homepage      = "https://github.com/xzhhe/cocoapods-virus"
  spec.license       = "MIT"
  spec.required_ruby_version = Gem::Requirement.new(">= 2.3.0")

  # spec.metadata["allowed_push_host"] = "TODO: Set to 'http://mygemserver.com'"
  # spec.metadata["homepage_uri"] = spec.homepage
  # spec.metadata["source_code_uri"] = "TODO: Put your gem's public repo URL here."
  # spec.metadata["changelog_uri"] = "TODO: Put your gem's CHANGELOG.md URL here."

  # Specify which files should be added to the gem when it is released.
  # The `git ls-files -z` loads the files in the RubyGem that have been added into git.
  # spec.files         = Dir.chdir(File.expand_path('..', __FILE__)) do
  #   `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  # end
  # spec.bindir        = "exe"
  # spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  # spec.require_paths = ["lib"]

  spec.files = Dir["lib/**/*.rb"] + %w{ bin/virus README.md LICENSE.txt }
  spec.executables   = %w{ virus }
  spec.require_paths = %w{ lib }

  spec.add_runtime_dependency 'cocoapods', '>= 1.6.0', '< 2.0'
  spec.add_development_dependency "bundler", "~> 2.0"
  spec.add_development_dependency "rake", "~> 12.0"
  spec.add_development_dependency "rspec", "~> 3.0"
end
