# frozen_string_literal: true

require "spec_helper"

RSpec.describe Kagi::API::Models::Summary do
  describe ".for" do
    let :attributes do
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
      expect(described_class.for(**attributes)).to eq(
        described_class[
          meta: Kagi::API::Models::Content::Meta[id: "abc", node: "us-west", duration: 1_000],
          data: Kagi::API::Models::Content::Summary[output: "In a world...", tokens: 123]
        ]
      )
    end
  end
end
