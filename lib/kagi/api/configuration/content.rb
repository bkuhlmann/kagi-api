# frozen_string_literal: true

module Kagi
  module API
    module Configuration
      # Defines customizable API configuration content.
      Content = Struct.new :content_type, :token, :uri do
        def headers = {"Content-Type" => content_type}.compact
      end
    end
  end
end
