# OmniAuth Instagram Graph &nbsp;[![Build Status](https://secure.travis-ci.org/jetrockets/omniauth-instagram-graph.svg?branch=master)](https://travis-ci.org/jetrockets/omniauth-instagram-graph) [![Gem Version](https://img.shields.io/gem/v/omniauth-instagram-graph.svg)](https://rubygems.org/gems/omniauth-instagram-graph)

Instagram OAuth2 Strategy for OmniAuth.

Supports OAuth 2.0 server-side flow with new Instagram Basic Display API and Long Live Tokens. Read the Instagram docs for more details: https://developers.facebook.com/docs/instagram-basic-display-api/guides/getting-access-tokens-and-permissions

Inspired by [OmniAuth Strategy for Facebook](https://github.com/simi/omniauth-facebook).

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

## Configuring

You can configure several options, which you pass in to the `provider` method via a `Hash`:

| Option name                         | Default                              | Description                                                                                                                    |
|-------------------------------------|--------------------------------------|---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|
| `scope`                               | `'user_profile,user_media'`          | A comma-separated list of permissions you want to request from the user.                                                                                                                                                                                                  |
| `info_fields`                         | `'account_type,id,media_count,username'` | A comma-separated list of fields should be returned when getting the user's info (see more https://developers.facebook.com/docs/instagram-basic-display-api/reference/user).                                                                                              |
| `callback_url`                        |                                      | Specify a custom callback URL used during the server-side flow. Note this must be allowed by your app configuration on Facebook (see 'Valid OAuth redirect URIs' under the 'Basic Display' settings section in the configuration for your Facebook app for more details). |
| `exchange_access_token_to_long_lived` | `true`                                 | Should `access_token` be exchanged to a Long-Lived token during callback phase of OmniAuth (see more about Long-Lived tokens here: https://developers.facebook.com/docs/instagram-basic-display-api/guides/long-lived-access-tokens)                                      |


## Auth Hash

Here's an example Auth Hash available in `request.env['omniauth.auth']`:

```
{
  provider: 'instagram_graph',
  uid: '1234567',
  info: {
    name: 'igor_alexandrov',
    nickname 'igor_alexandrov'
  },
  credentials: {
    token: 'ABCDEF...', # OAuth 2.0 access_token, which you may wish to store
    expires_at: 1321747205, # when the access token expires (it always will)
    expires: true # this will always be true
  },
  extra: {
    raw_info: {
      account_type: 'PERSONAL',
      id: '17841400519842852',
      media_count: 211,
      username: "igor_alexandrov"
    }
  }
}
```

## Long-Lived Tokens

Long-Lived Tokens are valid for 60 days. To be able to use token after, you need to refresh it. Here is a sample code, that will help.


``` ruby
client = OmniAuth::InstagramGraph::LongLivedClient.new(ENV['INSTAGRAM_APP_ID'], ENV['INSTAGRAM_APP_SECRET'])
token = client.get_token(access_token: "<CURRENT LONG-LIVED TOKEN>")
refreshed = token.refresh!
```

## Development

```
gem bump --file=lib/omniauth/instagram-graph/version.rb --push --tag --release --pretend
```

## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).

## Code of Conduct

Everyone interacting in the OmniAuth::Instagram::Graph project's codebases, issue trackers, chat rooms and mailing lists is expected to follow the [code of conduct](https://github.com/[USERNAME]/omniauth-instagram-graph/blob/master/CODE_OF_CONDUCT.md).
