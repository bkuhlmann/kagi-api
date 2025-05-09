# frozen_string_literal: true

module Kagi
  module API
    # Provides clean object inspection by stripping verbose contract information.
    module Inspectable
      def inspect
        super.sub(/@contract=.+?>,/, "@contract=#{contract.class},")
             .sub(/@error_contract=.+?>,/, "@error_contract=#{error_contract.class},")
      end
    end
  end
end
