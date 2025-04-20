# frozen_string_literal: true

module Kagi
  module API
    module Models
      module Content
        # Models fast data.
        Fast = Data.define :output, :tokens, :references do
          def self.for(**attributes)
            new(**attributes, references: attributes[:references].map { Reference[**it] })
          end
        end
      end
    end
  end
end
