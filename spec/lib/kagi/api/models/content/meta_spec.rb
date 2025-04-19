# frozen_string_literal: true

require "spec_helper"

RSpec.describe Kagi::API::Models::Content::Meta do
  subject(:model) { described_class[id: "abc", node: "us-west", duration: 10] }

  describe ".for" do
    it "transform attributes into record" do
      expect(described_class.for(id: "abc", node: "us-west", ms: 10, api_balance: 20)).to eq(
        described_class[id: "abc", node: "us-west", duration: 10, balance: 20]
      )
    end
  end

  describe "#initialize" do
    it "answers nil balance when not supplied" do
      expect(model).to eq(described_class[id: "abc", node: "us-west", duration: 10, balance: nil])
    end
  end
end
