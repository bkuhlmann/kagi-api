# frozen_string_literal: true

module Kagi
  module API
    module Contracts
      # Validates Fast GPT data.
      Fast = Dry::Schema.JSON do
        required(:meta).hash Meta

        required(:data).hash do
          required(:output).filled :string
          required(:tokens).filled :integer
          required(:references).array(Reference)
        end
      end
    end
  end
end
