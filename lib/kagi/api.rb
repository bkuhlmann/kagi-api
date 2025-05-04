# frozen_string_literal: true

require "dry/schema"
require "zeitwerk"

Dry::Schema.load_extensions :monads

Zeitwerk::Loader.new.then do |loader|
  loader.inflector.inflect "api" => "API"
  loader.tag = "kagi-api"
  loader.push_dir "#{__dir__}/.."
  loader.setup
end

module Kagi
  # Main namespace.
  module API
    def self.loader registry = Zeitwerk::Registry
      @loader ||= registry.loaders.find { |loader| loader.tag == "kagi-api" }
    end

    def self.new(&) = Client.new(&)
  end
end
