# frozen_string_literal: true

require "spec_helper"

RSpec.describe Kagi::API::Endpoints::Summarize do
  subject(:endpoint) { described_class.new requester: }

  let(:requester) { instance_double Kagi::API::Requester, post: Success(response) }

  describe "#call" do
    let(:response) { instance_double HTTP::Response, parse: payload }

    context "with unknown response" do
      let(:requester) { instance_double Kagi::API::Requester, post: :bogus }

      it "answers failure" do
        result = endpoint.call url: "https://test.io", summary_type: "summary"
        expect(result).to be_failure("Unable to parse HTTP response.")
      end
    end

    context "with success" do
      let :payload do
        {
          meta: {
            id: "abc",
            node: "us-west",
            ms: 1_000
          },
          data: {
            output: "In a world...",
            tokens: 123
          }
        }
      end

      it "answers record" do
        result = endpoint.call url: "https://test.io", summary_type: "summary"

        expect(result).to be_success(
          Kagi::API::Models::Summary[
            meta: Kagi::API::Models::Content::Meta[id: "abc", node: "us-west", duration: 1_000],
            data: Kagi::API::Models::Content::Summary[output: "In a world...", tokens: 123]
          ]
        )
      end
    end

    context "with failure" do
      let(:requester) { instance_double Kagi::API::Requester, post: Failure(response) }

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
end
