lib = File.expand_path("lib", __dir__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require "range_compacter/version"

Gem::Specification.new do |spec|
  spec.name          = "range_compacter"
  spec.version       = RangeCompacter::VERSION
  spec.authors       = ["OKURA Masafumi"]
  spec.email         = ["masafumi.o1988@gmail.com"]

  spec.summary       = "It accepts ranges or items with ranges and compacts them."
  spec.description   = "It accepts ranges or items with ranges and compacts them."
  spec.homepage      = "https://github.com/okuramasafumi/range_compacter"
  spec.license       = "MIT"

  spec.metadata["homepage_uri"] = spec.homepage
  spec.metadata["source_code_uri"] = "https://github.com/okuramasafumi/range_compacter"
  spec.metadata["changelog_uri"] = "https://github.com/okuramasafumi/range_compacter/CHANGELOG.md"

  # Specify which files should be added to the gem when it is released.
  # The `git ls-files -z` loads the files in the RubyGem that have been added into git.
  spec.files         = Dir.chdir(File.expand_path('..', __FILE__)) do
    `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  end
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 2.0"
  spec.add_development_dependency "rake", "~> 13.0"
  spec.add_development_dependency "minitest", "~> 5.0"
end
