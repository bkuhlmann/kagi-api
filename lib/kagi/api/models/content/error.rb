# frozen_string_literal: true

module Kagi
  module API
    module Models
      module Content
        ERROR_MAP = {msg: :message, ref: :reference}.freeze

        # Models error data.
        Error = Data.define :code, :message, :reference do
          def self.for(key_map: ERROR_MAP, **attributes)
            new(**attributes.transform_keys(key_map))
          end

          def initialize(reference: nil, **)
            super
          end
        end
      end
    end
  end
end
