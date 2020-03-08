# frozen_string_literal: true

require_relative 'lib/omniauth/instagram-graph/version'

Gem::Specification.new do |spec|
  spec.name = 'omniauth-instagram-graph'
  spec.version = OmniAuth::InstagramGraph::VERSION
  spec.authors = ['Igor Alexandrov']
  spec.email = ['igor.alexandrov@gmail.com']

  spec.summary = 'instagram Graph OAuth2 Strategy for OmniAuth'
  spec.homepage = 'http://github.com/jetrockets/omniauth-instagram-graph'
  spec.license = 'MIT'
  spec.required_ruby_version = Gem::Requirement.new('>= 2.3.0')

  spec.metadata['homepage_uri'] = spec.homepage
  spec.metadata['source_code_uri'] = 'http://github.com/jetrockets/omniauth-instagram-graph'

  spec.files = `git ls-files`.split("\n")
  spec.test_files = `git ls-files -- {test,spec,features}/*`.split("\n")
  spec.executables = `git ls-files -- bin/*`.split("\n").map { |f| File.basename(f) }
  spec.require_paths = ['lib']

  spec.add_runtime_dependency 'omniauth', '~> 1.9'
  spec.add_runtime_dependency 'omniauth-oauth2', '~> 1.2'

  spec.add_development_dependency 'minitest'
  spec.add_development_dependency 'mocha'
  spec.add_development_dependency 'rake'

  spec.add_development_dependency 'jetrockets-standard'
end
