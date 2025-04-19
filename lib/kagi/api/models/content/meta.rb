# frozen_string_literal: true

module Kagi
  module API
    module Models
      module Content
        META_MAP = {ms: :duration, api_balance: :balance}.freeze

        # Models meta data.
        Meta = Data.define :id, :node, :duration, :balance do
          def self.for(key_map: META_MAP, **attributes) = new(**attributes.transform_keys(key_map))

          def initialize(balance: nil, **)
            super
          end
        end
      end
    end
  end
end
