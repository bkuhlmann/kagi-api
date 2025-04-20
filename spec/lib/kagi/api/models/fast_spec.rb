# frozen_string_literal: true

require "spec_helper"

RSpec.describe Kagi::API::Models::Fast do
  describe ".for" do
    let :attributes do
      {
        meta: {
          id: "abc",
          node: "us-west",
          ms: 10
        },
        data: {
          output: "This is a test.",
          tokens: 123,
          references: [
            {
              title: "Test",
              snippet: "A test.",
              url: "https://test.io"
            }
          ]
        }
      }
    end

    it "answers record" do
      expect(described_class.for(**attributes)).to eq(
        described_class[
          meta: Kagi::API::Models::Content::Meta[id: "abc", node: "us-west", duration: 10],
          data: Kagi::API::Models::Content::Fast[
            output: "This is a test.",
            tokens: 123,
            references: [
              Kagi::API::Models::Content::Reference[
                title: "Test",
                snippet: "A test.",
                url: "https://test.io"
              ]
            ]
          ]
        ]
      )
    end
  end
end
