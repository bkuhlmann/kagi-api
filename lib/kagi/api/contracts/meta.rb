# frozen_string_literal: true

module Kagi
  module API
    module Contracts
      # Validates meta data.
      Meta = Dry::Schema.JSON do
        required(:id).filled :string
        required(:node).filled :string
        required(:ms).filled :integer
        optional(:api_balance) { filled? > int? | float? }
      end
    end
  end
end
