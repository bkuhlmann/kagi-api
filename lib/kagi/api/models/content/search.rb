# frozen_string_literal: true

module Kagi
  module API
    module Models
      module Content
        SEARCH_MAP = {t: :type, published: :published_at}.freeze

        # Models search data.
        Search = Data.define :type, :rank, :title, :url, :snippet, :published_at, :thumbnail do
          def self.for(key_map: SEARCH_MAP, **attributes)
            new(
              **attributes.transform_keys(key_map),
              thumbnail: (Thumbnail[**attributes[:thumbnail]] if attributes.key? :thumbnail)
            )
          end

          # rubocop:todo Metrics/ParameterLists
          def initialize(
            rank: nil,
            title: nil,
            url: nil,
            snippet: nil,
            published_at: nil,
            thumbnail: nil,
            **attributes
          )
            super
          end
          # rubocop:enable Metrics/ParameterLists
        end
      end
    end
  end
end
