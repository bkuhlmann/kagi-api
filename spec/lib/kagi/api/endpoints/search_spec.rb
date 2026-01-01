# frozen_string_literal: true

require "spec_helper"

RSpec.describe Kagi::API::Endpoints::Search do
  subject(:endpoint) { described_class.new requester: }

  let(:requester) { instance_double Kagi::API::Requester, get: Success(response) }

  describe "#call" do
    let(:response) { instance_double HTTP::Response, parse: payload }

    context "with unknown response" do
      let(:requester) { instance_double Kagi::API::Requester, get: :bogus }

      it "answers failure" do
        result = endpoint.call q: "Steve Jobs"
        expect(result).to be_failure("Unable to parse HTTP response.")
      end
    end

    context "with success" do
      let :payload do
        {
          meta: {
            id: "abc",
            node: "us-west",
            ms: 10,
            api_balance: 2.5
          },
          data: [
            {
              t: 0,
              url: "https://en.wikipedia.org/wiki/Steve_Jobs",
              title: "Steve Jobs - Wikipedia",
              snippet: "An inventor."
            }
          ]
        }
      end

      it "answers record" do
        result = endpoint.call q: "Steve Jobs"

        expect(result).to be_success(
          Kagi::API::Models::Search[
            meta: Kagi::API::Models::Content::Meta[
              id: "abc",
              node: "us-west",
              duration: 10,
              balance: 2.5
            ],
            data: [
              Kagi::API::Models::Content::Search[
                type: 0,
                url: "https://en.wikipedia.org/wiki/Steve_Jobs",
                title: "Steve Jobs - Wikipedia",
                snippet: "An inventor."
              ]
            ]
          ]
        )
      end
    end

    context "with failure" do
      let(:requester) { instance_double Kagi::API::Requester, get: Failure(response) }

      let :payload do
        {
          meta: {
            id: "abc",
            node: "us-west",
            ms: 20,
            api_balance: 2.5
          },
          data: nil,
          error: [
            {
              code: 1,
              msg: "Danger!",
              ref: nil
            }
          ]
        }
      end

      it "answers record" do
        result = endpoint.call url: "https://test.io", summary_type: "bogus"

        expect(result).to be_failure(
          Kagi::API::Models::Error[
            meta: Kagi::API::Models::Content::Meta[
              id: "abc",
              node: "us-west",
              duration: 20,
              balance: 2.5
            ],
            error: [Kagi::API::Models::Content::Error[code: 1, message: "Danger!"]]
          ]
        )
      end
    end
  end

  describe "#inspect" do
    it "has inspected attributes" do
      expect(described_class.new.inspect).to match_inspection(
        contract: "Dry::Schema::JSON",
        error_contract: "Dry::Schema::JSON"
      )
    end
  end
end
