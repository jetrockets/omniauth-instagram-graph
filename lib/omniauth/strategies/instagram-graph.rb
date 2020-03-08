# frozen_string_literal: true

require 'omniauth/strategies/oauth2'
require 'omniauth/instagram-graph/long_lived_token'
require 'omniauth/instagram-graph/long_lived_client'
require 'openssl'
require 'rack/utils'
require 'uri'

module OmniAuth
  module Strategies
    class InstagramGraph < OmniAuth::Strategies::OAuth2
      class NoAuthorizationCodeError < StandardError; end

      DEFAULT_SCOPE = 'user_profile,user_media'
      USER_INFO_URL = 'https://graph.instagram.com/me'

      option :name, 'instagram_graph'

      option :client_options, {
        site: 'https://api.instagram.com',
        authorize_url: 'https://api.instagram.com/oauth/authorize',
        token_url: 'oauth/access_token',
      }

      option :exchange_access_token_to_long_lived, true

      option :authorize_options, [:scope, :display, :auth_type]

      uid { raw_info['id'] }

      info do
        prune!({
          'nickname' => raw_info['username'],
          'name' => raw_info['username'],
        })
      end

      extra do
        hash = {}
        hash['raw_info'] = raw_info unless skip_info?
        prune! hash
      end

      def raw_info
        @raw_info ||= access_token.get(USER_INFO_URL, info_options).parsed || {}
      end

      def info_options
        params = {}
        params[:fields] = (options[:info_fields] || 'account_type,id,media_count,username')

        {params: params}
      end

      def callback_url
        options[:callback_url] || (full_host + script_name + callback_path)
      end

      # You can pass +scope+ param to the auth request, if you need to set them dynamically.
      # You can also set these options in the OmniAuth config :authorize_params option.
      def authorize_params
        super.tap do |params|
          %w[scope].each do |v|
            if request.params[v]
              params[v.to_sym] = request.params[v]
            end
          end

          params[:scope] ||= DEFAULT_SCOPE
        end
      end

      protected

      def build_access_token
        access_token = super

        if options.exchange_access_token_to_long_lived
          access_token = long_lived_client.get_token(access_token: access_token.token)
        end

        access_token
      end

      private

      def long_lived_client
        OmniAuth::InstagramGraph::LongLivedClient.new(client.id, client.secret)
      end

      def prune!(hash)
        hash.delete_if do |_, value|
          prune!(value) if value.is_a?(Hash)
          value.nil? || (value.respond_to?(:empty?) && value.empty?)
        end
      end
    end
  end
end
