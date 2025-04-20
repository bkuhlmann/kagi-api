# frozen_string_literal: true

require "spec_helper"

RSpec.describe Kagi::API::Models::Error do
  describe ".for" do
    let :attributes do
      {
        meta: {
          id: "abc",
          node: "us-west",
          ms: 20,
          api_balance: 2.5
        },
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
      expect(described_class.for(**attributes)).to eq(
        described_class[
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
