# frozen_string_literal: true

require "containable"

module Kagi
  module API
    module Endpoints
      # Registers all endpoints.
      module Container
        extend Containable

        namespace :enrich do
          register(:news) { Enrich::News.new }
          register(:web) { Enrich::Web.new }
        end

        register(:fast) { Fast.new }
        register(:search) { Search.new }
        register(:summarize) { Summarize.new }
      end
    end
  end
end
