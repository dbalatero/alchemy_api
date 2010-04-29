module AlchemyApi
  ExtractedText = Struct.new(:url, :text)
  ExtractedTitle = Struct.new(:url, :title)

  class TextExtraction < Base
    # Usage:
    # AlchemyApi::TextExtraction.get_text_from_url(
    #     "http://google.com",
    #     :use_metadata => 1,
    #     :extract_links => 1)
    post(:get_text_from_url) do |url, *args|
      options = args.first || {}
      uri "#{AlchemyApi.base_uri}/URLGetText"
      params :apikey => AlchemyApi.api_key,
             :useMetadata => options[:use_metadata] || 1,
             :extractLinks => options[:extract_links] || 0,
             :outputMode => 'json',
             :url => url

      handler do |response|
        AlchemyApi::TextExtraction.get_text_from_url_handler(response)
      end
    end

    post(:get_raw_text_from_url) do |url|
      uri "#{AlchemyApi.base_uri}/URLGetRawText"
      params :apikey => AlchemyApi.api_key,
             :url => url,
             :outputMode => 'json'
      handler do |response|
        AlchemyApi::TextExtraction.get_text_from_url_handler(response)
      end
    end

    post(:get_title_from_url) do |url, *args|
      options = args.first || {}
      uri "#{AlchemyApi.base_uri}/URLGetTitle"
      params :apikey => AlchemyApi.api_key,
             :url => url,
             :useMetadata => options[:use_metadata] || 1,
             :outputMode => 'json'
      handler do |response|
        AlchemyApi::TextExtraction.get_title_from_url_handler(response)
      end
    end

    post(:get_text_from_html) do |html, *args|
      options = args.first || {}
      uri "#{AlchemyApi.base_html_uri}/HTMLGetText"
      params :apikey => AlchemyApi.api_key,
             :url => options[:url] || '',
             :html => html,
             :useMetadata => options[:use_metadata] || 1,
             :extractLinks => options[:extract_links] || 0,
             :outputMode => 'json'
      handler do |response|
        AlchemyApi::TextExtraction.get_text_from_url_handler(response)
      end
    end

    post(:get_raw_text_from_html) do |html, *args|
      options = args.first || {}
      uri "#{AlchemyApi.base_html_uri}/HTMLGetRawText"
      params :apikey => AlchemyApi.api_key,
             :html => html,
             :url => options[:url] || '',
             :outputMode => 'json'
      handler do |response|
        AlchemyApi::TextExtraction.get_text_from_url_handler(response)
      end
    end

    post(:get_title_from_html) do |html, *args|
      options = args.first || {}
      uri "#{AlchemyApi.base_html_uri}/HTMLGetTitle"
      params :apikey => AlchemyApi.api_key,
             :url => options[:url] || '',
             :html => html,
             :useMetadata => options[:use_metadata] || 1,
             :outputMode => 'json'
      handler do |response|
        AlchemyApi::TextExtraction.get_title_from_url_handler(response)
      end
    end

    def self.get_title_from_url_handler(response)
      json = JSON.parse(response.body)
      check_json_for_errors_and_raise!(json)
      ExtractedTitle.new(json['url'], json['title'])
    end

    def self.get_text_from_url_handler(response)
      json = JSON.parse(response.body)
      check_json_for_errors_and_raise!(json)
      ExtractedText.new(json['url'], json['text'])
    end
  end
end
