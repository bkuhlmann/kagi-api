# frozen_string_literal: true

require "cogger"
require "containable"
require "http"

module Kagi
  module API
    # Registers application dependencies.
    module Container
      extend Containable

      register(:settings) { Configuration::Loader.new.call }
      register(:requester) { Requester.new }
      register(:logger) { Cogger.new id: "kagi-api", formatter: :json }

      register :http do
        HTTP.default_options = HTTP::Options.new features: {logging: {logger: self[:logger]}}
        HTTP
      end

      namespace :contracts do
        register :error, Contracts::Error
        register :fast, Contracts::Fast
        register :search, Contracts::Search
        register :summary, Contracts::Summary
      end

      namespace :models do
        register :error, Models::Error
        register :fast, Models::Fast
        register :search, Models::Search
        register :summary, Models::Summary
      end
    end
  end
end
