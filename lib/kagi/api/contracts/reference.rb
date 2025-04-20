# frozen_string_literal: true

module Kagi
  module API
    module Contracts
      # Validates reference data.
      Reference = Dry::Schema.JSON do
        required(:title).filled :string
        required(:snippet).filled :string
        required(:url).filled :string
      end
    end
  end
end
