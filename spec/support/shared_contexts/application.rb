# frozen_string_literal: true

RSpec.shared_context "with application dependencies" do
  let(:settings) { Kagi::API::Configuration::Content.new }
  let(:logger) { Cogger.new id: "kagi-api", io: StringIO.new, level: :debug }
  let(:http) { class_spy HTTP }

  before { Kagi::API::Container.stub! settings:, http:, logger: }

  after { Kagi::API::Container.restore }
end
