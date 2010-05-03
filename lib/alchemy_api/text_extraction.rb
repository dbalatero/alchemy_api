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
      params :url => url,
             :useMetadata => options[:use_metadata] || 1,
             :extractLinks => options[:extract_links] || 0

      handler do |response|
        AlchemyApi::TextExtraction.get_text_from_url_handler(response)
      end
    end

    post(:get_raw_text_from_url) do |url|
      uri "#{AlchemyApi.base_uri}/URLGetRawText"
      params :url => url
      handler do |response|
        AlchemyApi::TextExtraction.get_text_from_url_handler(response)
      end
    end

    post(:get_title_from_url) do |url, *args|
      options = args.first || {}
      uri "#{AlchemyApi.base_uri}/URLGetTitle"
      params :url => url,
             :useMetadata => options[:use_metadata] || 1
      handler do |response|
        AlchemyApi::TextExtraction.get_title_from_url_handler(response)
      end
    end

    post(:get_text_from_html) do |html, *args|
      options = args.first || {}
      uri "#{AlchemyApi.base_html_uri}/HTMLGetText"
      params :html => html,
             :url => options[:url] || '',
             :useMetadata => options[:use_metadata] || 1,
             :extractLinks => options[:extract_links] || 0
      handler do |response|
        AlchemyApi::TextExtraction.get_text_from_url_handler(response)
      end
    end

    post(:get_raw_text_from_html) do |html, *args|
      options = args.first || {}
      uri "#{AlchemyApi.base_html_uri}/HTMLGetRawText"
      params :html => html,
             :url => options[:url] || ''
      handler do |response|
        AlchemyApi::TextExtraction.get_text_from_url_handler(response)
      end
    end

    post(:get_title_from_html) do |html, *args|
      options = args.first || {}
      uri "#{AlchemyApi.base_html_uri}/HTMLGetTitle"
      params :html => html,
             :url => options[:url] || '',
             :useMetadata => options[:use_metadata] || 1
      handler do |response|
        AlchemyApi::TextExtraction.get_title_from_url_handler(response)
      end
    end

    def self.get_title_from_url_handler(response)
      json = get_json(response)
      ExtractedTitle.new(json['url'], json['title'])
    end

    def self.get_text_from_url_handler(response)
      json = get_json(response)
      check_json_for_errors_and_raise!(json)
      ExtractedText.new(json['url'], json['text'])
    end
  end
end
