# frozen_string_literal: true

module Kagi
  module API
    module Models
      module Content
        # Models thumbnail data.
        Thumbnail = Data.define :url, :width, :height do
          def initialize url:, width: nil, height: nil
            super
          end
        end
      end
    end
  end
end
