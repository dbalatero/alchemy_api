require 'ostruct'
require 'json'

# for now this is local
require '/Users/dbalatero/oss/monster_mash/lib/monster_mash'

Dir.glob(File.dirname(__FILE__) + "/**/*.rb").each do |f|
  require f
end

module AlchemyApi
  @api_key = nil
  @base_uri = "http://access.alchemyapi.com/calls/url"
  @base_html_uri = "http://access.alchemyapi.com/calls/html"
  @base_text_uri = "http://access.alchemyapi.com/calls/text"

  class << self
    attr_accessor :api_key
    attr_accessor :base_uri
    attr_accessor :base_html_uri
    attr_accessor :base_text_uri
  end

  class UnknownError < StandardError; end
  class InvalidApiKeyError < StandardError; end
  class CannotRetrieveUrlError < StandardError; end
  class RedirectionLimitError < CannotRetrieveUrlError; end
  class PageIsNotValidHtmlError < StandardError; end
  class ContentExceedsMaxLimitError < StandardError; end
  class InvalidHtmlError < StandardError; end
end
