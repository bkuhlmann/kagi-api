# frozen_string_literal: true

module Kagi
  module API
    module Models
      # Models the API error.
      Error = Data.define :meta, :error do
        def self.for(**attributes)
          new(
            **attributes.merge!(
              meta: Content::Meta.for(**attributes[:meta]),
              error: attributes[:error].map { Content::Error.for(**it) }
            )
          )
        end
      end
    end
  end
end
