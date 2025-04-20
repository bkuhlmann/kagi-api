# frozen_string_literal: true

require "spec_helper"

RSpec.describe Kagi::API::Models::Content::Fast do
  describe ".for" do
    it "transform attributes into record" do
      record = described_class.for output: "This is a test.",
                                   tokens: 123,
                                   references: [
                                     {
                                       title: "Test",
                                       snippet: "A test.",
                                       url: "https://test.io"
                                     }
                                   ]

      expect(record).to eq(
        described_class[
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
      )
    end
  end
end
