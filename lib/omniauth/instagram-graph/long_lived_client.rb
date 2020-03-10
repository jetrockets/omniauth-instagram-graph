# frozen_string_literal: true

module OmniAuth
  module InstagramGraph
    class LongLivedClient < ::OAuth2::Client
      TOKEN_URL = '/access_token'

      def initialize(client_id, client_secret, options = {})
        options = {
          site: 'https://graph.instagram.com',
          authorize_url: nil,
          token_url: TOKEN_URL,
          token_method: :get,
        }.merge!(options)

        super(client_id, client_secret, options)
      end

      def get_token(params = {})
        params = {grant_type: 'ig_exchange_token', client_secret: secret}.merge!(params)
        super(params, {}, LongLivedToken)
      end
    end
  end
end
