# frozen_string_literal: true

module Kagi
  module API
    # Provides the primary client for making API requests.
    class Client
      include Dependencies[:settings]

      include Endpoints::Dependencies[
        endpoint_enrich_news: "enrich.news",
        endpoint_enrich_web: "enrich.web",
        endpoint_fast: :fast,
        endpoint_search: :search,
        endpoint_summarize: :summarize
      ]

      def initialize(**)
        super
        yield settings if block_given?
      end

      def enrich_news(**) = endpoint_enrich_news.call(**)

      def enrich_web(**) = endpoint_enrich_web.call(**)

      def fast(**) = endpoint_fast.call(**)

      def search(**) = endpoint_search.call(**)

      def summarize(**) = endpoint_summarize.call(**)
    end
  end
end
