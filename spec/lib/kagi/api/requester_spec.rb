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
    before do
      response = HTTP::Response.new headers: {content_type: "text/html"},
                                    body: "Not Found",
                                    status: 404,
                                    version: 1.0

      allow(http).to receive(:get).and_return response
    end

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
    before do
      response = HTTP::Response.new headers: {content_type: "application/json"},
                                    body: {
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
                                    }.to_json,
                                    status: 200,
                                    version: 1.0

      allow(http).to receive(:get).and_return response
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
    before do
      response = HTTP::Response.new headers: {content_type: "application/json"},
                                    body: {
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
                                    }.to_json,
                                    status: 200,
                                    version: 1.0

      allow(http).to receive(:post).and_return response
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
