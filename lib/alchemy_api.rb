require 'ostruct'
require 'json'
require 'monster_mash'

$LOAD_PATH.unshift(File.dirname(__FILE__))
require 'alchemy_api/base'
require 'alchemy_api/categorization'
require 'alchemy_api/concept_tagging'
require 'alchemy_api/language_detection'
require 'alchemy_api/term_extraction'
require 'alchemy_api/text_extraction'
require 'alchemy_api/named_entity_extraction'

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
  class ContentIsEmptyError < StandardError; end
end
