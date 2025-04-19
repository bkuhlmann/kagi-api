# frozen_string_literal: true

module Kagi
  module API
    module Contracts
      # Validates error data.
      Error = Dry::Schema.JSON do
        required(:meta).hash Meta

        required(:error).array(:hash) do
          required(:code).filled :integer
          required(:msg).filled :string
          required(:ref).maybe :string
        end
      end
    end
  end
end
