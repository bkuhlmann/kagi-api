# frozen_string_literal: true

require "spec_helper"

RSpec.describe Kagi::API::Configuration::Loader do
  subject(:loader) { described_class.new environment: Hash.new }

  describe "#call" do
    it "answers default configuration when environment is unset" do
      expect(loader.call).to eq(
        Kagi::API::Configuration::Content[
          content_type: "application/json",
          uri: "https://kagi.com/api/v0"
        ]
      )
    end

    it "answers custom configuration when environment is set" do
      loader = described_class.new environment: {
        "KAGI_API_CONTENT_TYPE" => "application/xml",
        "KAGI_API_TOKEN" => "abc123",
        "KAGI_API_URI" => "https://api.kagi.com"
      }

      expect(loader.call).to eq(
        Kagi::API::Configuration::Content[
          content_type: "application/xml",
          token: "abc123",
          uri: "https://api.kagi.com"
        ]
      )
    end
  end
end
