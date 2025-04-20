# frozen_string_literal: true

module Kagi
  module API
    module Models
      # Models the search payload.
      Search = Data.define :meta, :data do
        def self.for(**attributes)
          new(
            **attributes.merge!(
              meta: Content::Meta.for(**attributes[:meta]),
              data: attributes[:data].map { Content::Search.for(**it) }
            )
          )
        end
      end
    end
  end
end
