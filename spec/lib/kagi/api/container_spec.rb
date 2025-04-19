# frozen_string_literal: true

require "spec_helper"

RSpec.describe Kagi::API::Container do
  subject(:container) { described_class }

  describe ".[]" do
    it "answers HTTP dependency" do
      expect(container[:http]).to eq(HTTP)
    end
  end
end
