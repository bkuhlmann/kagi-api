# frozen_string_literal: true

require "spec_helper"

RSpec.describe Kagi::API::Models::Content::Error do
  subject(:model) { described_class[code: 1, message: "Danger!"] }

  describe ".for" do
    it "transform attributes into record" do
      expect(described_class.for(code: 1, msg: "Danger!", ref: "abc")).to eq(
        described_class[code: 1, message: "Danger!", reference: "abc"]
      )
    end
  end

  describe "#initialize" do
    it "answers nil reference when not supplied" do
      expect(model).to eq(described_class[code: 1, message: "Danger!", reference: nil])
    end
  end
end
