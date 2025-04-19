# frozen_string_literal: true

require "initable"

module Kagi
  module API
    module Configuration
      # Loads configuration based on environment or falls back to defaults.
      class Loader
        include Initable[model: Content, environment: ENV]

        def call
          model[
            content_type: environment.fetch("KAGI_API_CONTENT_TYPE", "application/json"),
            token: environment["KAGI_API_TOKEN"],
            uri: environment.fetch("KAGI_API_URI", "https://kagi.com/api/v0")
          ]
        end
      end
    end
  end
end
