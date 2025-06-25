# frozen_string_literal: true

Gem::Specification.new do |spec|
  spec.name = "kagi-api"
  spec.version = "0.1.1"
  spec.authors = ["Brooke Kuhlmann"]
  spec.email = ["brooke@alchemists.io"]
  spec.homepage = "https://alchemists.io/projects/kagi-api"
  spec.summary = "A Kagi API client for privacy focused information."
  spec.license = "Hippocratic-2.1"

  spec.metadata = {
    "bug_tracker_uri" => "https://github.com/bkuhlmann/kagi-api/issues",
    "changelog_uri" => "https://alchemists.io/projects/kagi-api/versions",
    "homepage_uri" => "https://alchemists.io/projects/kagi-api",
    "funding_uri" => "https://github.com/sponsors/bkuhlmann",
    "label" => "Kagi API",
    "rubygems_mfa_required" => "true",
    "source_code_uri" => "https://github.com/bkuhlmann/kagi-api"
  }

  spec.signing_key = Gem.default_key_path
  spec.cert_chain = [Gem.default_cert_path]

  spec.required_ruby_version = "~> 3.4"
  spec.add_dependency "cogger", "~> 1.2"
  spec.add_dependency "containable", "~> 1.2"
  spec.add_dependency "dry-monads", "~> 1.9"
  spec.add_dependency "http", "~> 5.2"
  spec.add_dependency "infusible", "~> 4.3"
  spec.add_dependency "initable", "~> 0.4"
  spec.add_dependency "inspectable", "~> 0.3"
  spec.add_dependency "pipeable", "~> 1.3"
  spec.add_dependency "zeitwerk", "~> 2.7"

  spec.extra_rdoc_files = Dir["README*", "LICENSE*"]
  spec.files = Dir["*.gemspec", "lib/**/*"]
end
