# frozen_string_literal: true

RSpec.shared_examples "an inspectable endpoint" do |object|
  it "answers string with class names for contracts" do
    expect(object.inspect).to include(
      "@contract=Dry::Schema::JSON, @error_contract=Dry::Schema::JSON, "
    )
  end
end
