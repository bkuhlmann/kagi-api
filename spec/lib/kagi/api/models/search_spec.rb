# frozen_string_literal: true

require "spec_helper"

RSpec.describe Kagi::API::Models::Search do
  subject(:model) { described_class.new }

  describe ".for" do
    let :attributes do
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
            snippet: "An inventor.",
            thumbnail: {
              url: "/proxy/avatar.png",
              width: 250,
              height: 300
            }
          },
          {
            t: 0,
            url: "https://www.britannica.com/money/Steve-Jobs",
            title: "Steve Jobs | Britannica Money",
            snippet: "The visionary co-founder of Apple.",
            published: "2024-09-30T00:00:00Z"
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
            duration: 10,
            balance: 2.5
          ],
          data: [
            Kagi::API::Models::Content::Search[
              type: 0,
              url: "https://en.wikipedia.org/wiki/Steve_Jobs",
              title: "Steve Jobs - Wikipedia",
              snippet: "An inventor.",
              thumbnail: Kagi::API::Models::Content::Thumbnail[
                url: "/proxy/avatar.png",
                width: 250,
                height: 300
              ]
            ],
            Kagi::API::Models::Content::Search[
              type: 0,
              url: "https://www.britannica.com/money/Steve-Jobs",
              title: "Steve Jobs | Britannica Money",
              snippet: "The visionary co-founder of Apple.",
              published_at: "2024-09-30T00:00:00Z"
            ]
          ]
        ]
      )
    end
  end
end
