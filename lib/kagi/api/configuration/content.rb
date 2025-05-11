# frozen_string_literal: true

require "inspectable"

module Kagi
  module API
    module Configuration
      # Defines customizable API configuration content.
      Content = Struct.new :content_type, :token, :uri do
        include Inspectable[token: :redact]

        def headers = {"Content-Type" => content_type}.compact
      end
    end
  end
end
