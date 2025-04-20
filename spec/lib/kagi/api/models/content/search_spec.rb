# frozen_string_literal: true

require "spec_helper"

RSpec.describe Kagi::API::Models::Content::Search do
  subject(:model) { described_class[type: 0] }

  describe ".for" do
    it "transform attributes into record" do
      record = described_class.for t: 0,
                                   title: "Test",
                                   url: "https://test.io",
                                   published: "2025-04-20"

      expect(record).to eq(
        described_class[
          type: 0,
          rank: nil,
          url: "https://test.io",
          title: "Test",
          snippet: nil,
          published_at: "2025-04-20",
          thumbnail: nil
        ]
      )
    end
  end

  describe "#initialize" do
    it "answers nil for optional attribuets" do
      expect(model).to eq(
        described_class[
          type: 0,
          rank: nil,
          url: nil,
          title: nil,
          snippet: nil,
          published_at: nil,
          thumbnail: nil
        ]
      )
    end
  end
end
