$LOAD_PATH.unshift(File.dirname(__FILE__))
$LOAD_PATH.unshift(File.join(File.dirname(__FILE__), '..', 'lib'))
require 'alchemy_api'
require 'spec'
require 'spec/autorun'

AlchemyApi.api_key = '3468d2194732163c69b0ac76079ca9f9c4193226'

require 'typhoeus_spec_cache'

Spec::Runner.configure do |config|
  config.include(Typhoeus::SpecCacheMacros::InstanceMethods)
  config.extend(Typhoeus::SpecCacheMacros::ClassMethods)

  def fixture_for(path)
    File.read(fixture_path(path))
  end

  def fixture_path(path)
    File.expand_path(File.dirname(__FILE__) + "/fixtures/#{path}")
  end
end
