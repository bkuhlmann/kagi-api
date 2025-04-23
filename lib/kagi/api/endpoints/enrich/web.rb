# frozen_string_literal: true

require "dry/monads"
require "pipeable"

module Kagi
  module API
    module Endpoints
      module Enrich
        # Handles web requests.
        class Web
          include Kagi::API::Dependencies[
            :requester,
            contract: "contracts.search",
            error_contract: "contracts.error",
            model: "models.search",
            error_model: "models.error"
          ]

          include Dry::Monads[:result]
          include Pipeable

          def call(**params)
            result = requester.get("enrich/web", **params)

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
end
