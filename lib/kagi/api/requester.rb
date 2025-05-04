# frozen_string_literal: true

module Kagi
  module API
    # The low-level object for making basic HTTP requests.
    class Requester
      include Dependencies[:settings, :http]
      include Dry::Monads[:result]

      def initialize(**)
        super
        yield settings if block_given?
      end

      def get(path, **params) = call(__method__, path, params:)

      def post(path, **json) = call(__method__, path, json:)

      private

      attr_reader :settings

      def call verb, path, **options
        http.auth("Bot #{settings.token}")
            .headers(settings.headers)
            .public_send(verb, "#{settings.uri}/#{path}", options)
            .then { |response| response.status.success? ? Success(response) : Failure(response) }
      end
    end
  end
end
