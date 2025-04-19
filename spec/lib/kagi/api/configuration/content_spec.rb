# frozen_string_literal: true

require "spec_helper"

RSpec.describe Kagi::API::Configuration::Content do
  subject(:content) { described_class[content_type: "application/json"] }

  describe "#headers" do
    it "answers HTTP headers when defined" do
      expect(content.headers).to eq("Content-Type" => "application/json")
    end

    it "answers empty hash when none are available" do
      content.content_type = nil
      expect(content.headers).to eq({})
    end
  end
end
