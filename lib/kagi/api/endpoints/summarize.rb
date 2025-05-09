# frozen_string_literal: true

require "dry/monads"
require "inspectable"
require "pipeable"

module Kagi
  module API
    module Endpoints
      # Handles summarize requests.
      class Summarize
        include Kagi::API::Dependencies[
          :requester,
          contract: "contracts.summary",
          error_contract: "contracts.error",
          model: "models.summary",
          error_model: "models.error"
        ]

        include Dry::Monads[:result]
        include Pipeable
        include Inspectable[contract: :class, error_contract: :class]

        def call(**params)
          result = requester.post("summarize", **params)

          case result
            in Success then success result
            in Failure(response) then failure response
            else Failure "Unable to parse HTTP response."
          end
        end

        private

        def success result
          pipe result,
               try(:parse, catch: JSON::ParserError),
               validate(contract, as: :to_h),
               to(model, :for)
        end

        def failure response
          pipe(
            response,
            try(:parse, catch: JSON::ParserError),
            validate(error_contract, as: :to_h),
            to(error_model, :for),
            bind { Failure it }
          )
        end
      end
    end
  end
end
