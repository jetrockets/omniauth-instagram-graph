# frozen_string_literal: true

require 'helper'
require 'omniauth-instagram-graph'
require 'openssl'
require 'base64'

class StrategyTest < StrategyTestCase
  # include OAuth2StrategyTests
end

class ClientTest < StrategyTestCase
  test 'has correct Instagram site' do
    assert_equal 'https://api.instagram.com', strategy.client.site
  end

  test 'has correct authorize url' do
    assert_equal 'https://api.instagram.com/oauth/authorize', strategy.client.options[:authorize_url]
  end

  test 'has correct token url' do
    assert_equal 'oauth/access_token', strategy.client.options[:token_url]
    assert_equal 'https://api.instagram.com/oauth/access_token', strategy.client.token_url
  end
end
