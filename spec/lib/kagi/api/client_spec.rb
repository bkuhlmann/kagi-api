# frozen_string_literal: true

require "spec_helper"

RSpec.describe Kagi::API::Client do
  subject(:client) { described_class.new }

  include_context "with application dependencies"

  describe "#initialize" do
    it "answers original settings without block" do
      client
      expect(settings).to eq(Kagi::API::Configuration::Content.new)
    end

    it "modifies settings with block" do
      described_class.new { |settings| settings.uri = "https://api.test.io" }
      expect(settings).to eq(Kagi::API::Configuration::Content[uri: "https://api.test.io"])
    end
  end

  describe "#enrich_news" do
    let(:endpoint) { instance_spy Kagi::API::Endpoints::Enrich::News }

    it "messages endpoint" do
      client = described_class.new endpoint_enrich_news: endpoint
      expect(client.enrich_news).to have_received(:call)
    end
  end

  describe "#enrich_web" do
    let(:endpoint) { instance_spy Kagi::API::Endpoints::Enrich::Web }

    it "messages endpoint" do
      client = described_class.new endpoint_enrich_web: endpoint
      expect(client.enrich_web).to have_received(:call)
    end
  end

  describe "#fast" do
    let(:endpoint) { instance_spy Kagi::API::Endpoints::Fast }

    it "messages endpoint" do
      client = described_class.new endpoint_fast: endpoint
      expect(client.fast).to have_received(:call)
    end
  end

  describe "#search" do
    let(:endpoint) { instance_spy Kagi::API::Endpoints::Search }

    it "messages endpoint" do
      client = described_class.new endpoint_search: endpoint
      expect(client.search).to have_received(:call)
    end
  end

  describe "#summarize" do
    subject(:client) { described_class.new endpoint_summarize: endpoint }

    let(:endpoint) { instance_spy Kagi::API::Endpoints::Summarize }

    it "messages endpoint" do
      expect(client.summarize).to have_received(:call)
    end
  end
end
