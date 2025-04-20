# frozen_string_literal: true

module Kagi
  module API
    module Models
      # Models the fast payload.
      Fast = Data.define :meta, :data do
        def self.for(**attributes)
          new(
            **attributes.merge!(
              meta: Content::Meta.for(**attributes[:meta]),
              data: Content::Fast.for(**attributes[:data])
            )
          )
        end
      end
    end
  end
end
