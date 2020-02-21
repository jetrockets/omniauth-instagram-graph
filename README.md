# OmniAuth Instagram Graph &nbsp;[![Build Status](https://secure.travis-ci.org/jetrockets/omniauth-instagram-graph.svg?branch=master)](https://travis-ci.org/jetrockets/omniauth-instagram-graph) [![Gem Version](https://img.shields.io/gem/v/omniauth-instagram-graph.svg)](https://rubygems.org/gems/omniauth-instagram-graph)

Instagram OAuth2 Strategy for OmniAuth.

Supports OAuth 2.0 server-side flow with new Instagram Basic Display API and Long Live Tokens. Read the Instagram docs for more details: https://developers.facebook.com/docs/instagram-basic-display-api/guides/getting-access-tokens-and-permissions

## Installing

Add to your `Gemfile`:

```ruby
gem 'omniauth-instagram-graph'
```

Then `bundle install`.

## Usage

`OmniAuth::Strategies::InstagramGraph` is simply a Rack middleware. Read the OmniAuth docs for detailed instructions: https://github.com/intridea/omniauth.

Here's a quick example, adding the middleware to a Rails app in `config/initializers/omniauth.rb`:

```ruby
Rails.application.config.middleware.use OmniAuth::Builder do
  provider :instagram_graph, ENV['INSTAGRAM_APP_ID'], ENV['INSTAGRAM_APP_SECRET']
end
```

## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).

## Code of Conduct

Everyone interacting in the Omniauth::Instagram::Graph project's codebases, issue trackers, chat rooms and mailing lists is expected to follow the [code of conduct](https://github.com/[USERNAME]/omniauth-instagram-graph/blob/master/CODE_OF_CONDUCT.md).
