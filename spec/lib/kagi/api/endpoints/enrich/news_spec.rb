# frozen_string_literal: true

require "spec_helper"

RSpec.describe Kagi::API::Endpoints::Enrich::News do
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
            ms: 10
          },
          data: [
            {
              t: 0,
              rank: 1,
              url: "https://en.wikipedia.org/wiki/Steve_Jobs",
              title: "Steve Jobs - Wikipedia",
              snippet: "An inventor.",
              published: "2025-04-20T01:02:03Z"
            }
          ]
        }
      end

      it "answers record" do
        result = endpoint.call q: "Steve Jobs"

        expect(result).to be_success(
          Kagi::API::Models::Search[
            meta: Kagi::API::Models::Content::Meta[id: "abc", node: "us-west", duration: 10],
            data: [
              Kagi::API::Models::Content::Search[
                type: 0,
                rank: 1,
                url: "https://en.wikipedia.org/wiki/Steve_Jobs",
                title: "Steve Jobs - Wikipedia",
                snippet: "An inventor.",
                published_at: Time.utc(2025, 4, 20, 1, 2, 3)
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
    it_behaves_like "an inspectable endpoint", described_class.new
  end
end
