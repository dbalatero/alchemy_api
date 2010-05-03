module AlchemyApi
  TermExtractionResult = Struct.new(:keywords, :language, :url, :source_text)
  Keyword = Struct.new(:text, :relevance)

  class TermExtraction < Base
    post(:get_ranked_keywords_from_html) do |html, *args|
      options = args.first || {}
      uri "#{AlchemyApi.base_html_uri}/HTMLGetRankedKeywords"
      params :html => html,
             :url => options[:url],
             :maxRetrieve => options[:max_retrieve] || 10,
             :showSourceText => options[:show_source_text] ? 1 : 0,
             :sourceText => options[:source_text] || 'cleaned_or_raw',
             :cquery => options[:cquery],
             :xpath => options[:xpath]
      handler do |response|
        AlchemyApi::TermExtraction.get_ranked_keywords_handler(response)
      end
    end

    post(:get_ranked_keywords_from_url) do |url, *args|
      options = args.first || {}
      uri "#{AlchemyApi.base_uri}/URLGetRankedKeywords"
      params :url => url,
             :maxRetrieve => options[:max_retrieve] || 10,
             :showSourceText => options[:show_source_text] ? 1 : 0,
             :sourceText => options[:source_text] || 'cleaned_or_raw',
             :cquery => options[:cquery],
             :xpath => options[:xpath]
      handler do |response|
        AlchemyApi::TermExtraction.get_ranked_keywords_handler(response)
      end
    end

    post(:get_ranked_keywords_from_text) do |text, *args|
      options = args.first || {}
      uri "#{AlchemyApi.base_text_uri}/TextGetRankedKeywords"
      params :text => text,
             :url => options[:url],
             :maxRetrieve => options[:max_retrieve] || 10,
             :showSourceText => options[:show_source_text] ? 1 : 0
      handler do |response|
        AlchemyApi::TermExtraction.get_ranked_keywords_handler(response)
      end
    end

    def self.get_ranked_keywords_handler(response)
      json = get_json(response)
      keywords = json['keywords'].map do |kw|
        Keyword.new(kw['text'], kw['relevance'].to_f)
      end
      TermExtractionResult.new(keywords, json['language'],
                               json['url'], json['text'])
    end
  end
end
