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

class CallbackUrlTest < StrategyTestCase
  test "returns the default callback url" do
    url_base = "http://example.com"
    @request.stubs(:url).returns("#{url_base}/foo/")
    strategy.stubs(:script_name).returns("") # as not to depend on Rack env
    assert_equal "#{url_base}/auth/instagram_graph/callback", strategy.callback_url
  end

  test "returns path from callback_path option" do
    @options = { :callback_path => "/callback/custom_path" }
    url_base = "http://example.com"
    @request.stubs(:url).returns("#{url_base}/foo/")
    strategy.stubs(:script_name).returns("") # as not to depend on Rack env
    assert_equal "#{url_base}/callback/custom_path", strategy.callback_url
  end

  test "returns callback_url when setting script_name" do
    url_base = "http://example.com"
    @request.stubs(:url).returns("#{url_base}/foo/")
    strategy.stubs(:script_name).returns("/bar") # as not to depend on Rack env
    assert_equal "#{url_base}/bar/auth/instagram_graph/callback", strategy.callback_url
  end
end