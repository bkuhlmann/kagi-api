# frozen_string_literal: true

module Kagi
  module API
    module Contracts
      # Validates search data.
      Search = Dry::Schema.JSON do
        required(:meta).hash Meta

        required(:data).array(:hash) do
          required(:t).filled :integer
          optional(:rank).filled :integer
          optional(:url).filled :string
          optional(:title).filled :string
          optional(:snippet).maybe :string
          optional(:published).filled :time

          optional(:thumbnail).hash do
            required(:url).filled :string
            optional(:width).filled :integer
            optional(:height).filled :integer
          end
        end
      end
    end
  end
end
