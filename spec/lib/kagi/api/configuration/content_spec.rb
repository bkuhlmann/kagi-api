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

  describe "#inspect" do
    subject(:content) { described_class[token: "secret"] }

    it "filters token" do
      expect(content.inspect).to eq(
        %(#<struct Kagi::API::Configuration::Content content_type=nil, token="[REDACTED]", uri=nil>)
      )
    end
  end
end
