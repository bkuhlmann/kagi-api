# frozen_string_literal: true

require "spec_helper"

RSpec.describe Kagi::API::Inspectable do
  subject :implementation do
    Class.new do
      include Kagi::API::Inspectable

      def initialize contract: Kagi::API::Contracts::Search,
                     error_contract: Kagi::API::Contracts::Error,
                     test: :test
        @contract = contract
        @error_contract = error_contract
        @test = test
      end

      private

      attr_reader :contract, :error_contract, :test
    end
  end

  describe "#inspect" do
    it "swaps contracts for class names" do
      expect(implementation.new.inspect).to include(
        "@contract=Dry::Schema::JSON, @error_contract=Dry::Schema::JSON, @test=:test"
      )
    end
  end
end
