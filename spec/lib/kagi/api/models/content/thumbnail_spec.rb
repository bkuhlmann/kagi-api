# frozen_string_literal: true

require "spec_helper"

RSpec.describe Kagi::API::Models::Content::Thumbnail do
  subject(:model) { described_class[url: "https://test.io"] }

  describe "#initialize" do
    it "answers nil width and height when not supplied" do
      expect(model).to eq(described_class[url: "https://test.io", width: nil, height: nil])
    end
  end
end
