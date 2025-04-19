# frozen_string_literal: true

module Kagi
  module API
    module Contracts
      # Validates summary data.
      Summary = Dry::Schema.JSON do
        required(:meta).hash Meta

        required(:data).hash do
          required(:output).filled :string
          required(:tokens).filled :integer
        end
      end
    end
  end
end
