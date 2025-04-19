# frozen_string_literal: true

require "spec_helper"

RSpec.describe Kagi::API::Requester do
  using Refinements::Hash

  subject(:requester) { described_class.new }

  include_context "with application dependencies"

  let(:settings) { Kagi::API::Configuration::Content[uri: "https://kagi.com/api/v0"] }

  let :proof do
    {
      meta: {
        id: "123",
        node: "us-west2",
        ms: 24,
        api_balance: 3.9
      },
      data: {
        output: "Kagi is a company founded in 2018.",
        tokens: 0
      }
    }
  end

  describe "#initialize" do
    let(:http) { HTTP }

    it "initializes with block" do
      requester = described_class.new do |settings|
        settings.uri = "https://kagi.com/api/v0"
        settings.token = "bogus"
      end

      body = requester.get("bogus").failure.to_s

      expect(body).to include("Not Found")
    end
  end

  describe "#get" do
    let :http do
      HTTP::Fake::Client.new do
        get "/api/v0/summarize" do
          headers["Content-Type"] = "application/json"
          status 200

          <<~JSON
            {
              "meta": {
                "id": "123",
                "node": "us-west2",
                "ms": 24,
                "api_balance": 3.9
              },
              "data": {
                "output": "Kagi is a company founded in 2018.",
                "tokens": 0
              }
            }
          JSON
        end
      end
    end

    it "answers response" do
      result = requester.get "summarize",
                             url: "https://help.kagi.com/kagi/company",
                             summary_type: "summary",
                             engine: "cecil"
      payload = result.bind { |response| response.parse.deep_symbolize_keys }

      expect(payload).to eq(proof)
    end
  end

  describe "#post" do
    let :http do
      HTTP::Fake::Client.new do
        post "/api/v0/summarize" do
          headers["Content-Type"] = "application/json"
          status 200

          <<~JSON
            {
              "meta": {
                "id": "123",
                "node": "us-west2",
                "ms": 24,
                "api_balance": 3.9
              },
              "data": {
                "output": "Kagi is a company founded in 2018.",
                "tokens": 0
              }
            }
          JSON
        end
      end
    end

    it "answers response" do
      result = requester.post "summarize",
                              url: "https://help.kagi.com/kagi/company",
                              summary_type: "summary",
                              engine: "cecil"
      payload = result.bind { |response| response.parse.deep_symbolize_keys }

      expect(payload).to eq(proof)
    end
  end
end
