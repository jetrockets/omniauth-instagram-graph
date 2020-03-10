# frozen_string_literal: true

module OmniAuth
  module InstagramGraph
    class LongLivedToken < ::OAuth2::AccessToken
      TOKEN_REFRESH_PATH = '/refresh_access_token'

      def refresh!(params = {})
        options = {
          token_url: TOKEN_REFRESH_PATH,
        }
        refresh_client = OmniAuth::InstagramGraph::LongLivedClient.new(client.id, client.secret, options)

        params[:grant_type] = 'ig_refresh_token'
        params[:access_token] = token

        refresh_client.get_token(params)
      end
    end
  end
end
