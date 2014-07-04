# TODO: add support for linkedData return fields
module AlchemyApi
  ConceptTaggingResult = Struct.new(:concepts, :language, :url, :source_text)

  class ConceptTagging < Base
    # http://www.alchemyapi.com/api/concept/textc.html
    post(:get_concepts_from_text) do |text, *args|
      options = args.first || {}
      uri "#{AlchemyApi.base_text_uri}/TextGetRankedConcepts"
      params :text => text,
             :maxRetrieve => options[:max_retrieve] || 10,
             :linkedData => 0,
             :showSourceText => options[:show_source_text] ? 1 : 0
      handler do |response|
        AlchemyApi::ConceptTagging.get_concepts_handler(response)
      end
    end

    # http://www.alchemyapi.com/api/concept/urls.html
    post(:get_concepts_from_url) do |url, *args|
      options = args.first || {}
      uri "#{AlchemyApi.base_uri}/URLGetRankedConcepts"
      params :url => url,
             :maxRetrieve => options[:max_retrieve] || 10,
             :linkedData => 0,
             :showSourceText => options[:show_source_text] ? 1 : 0,
             :sourceText => options[:source_text] || 'cleaned_or_raw',
             :cquery => options[:cquery],
             :xpath => options[:xpath]
      handler do |response|
        AlchemyApi::ConceptTagging.get_concepts_handler(response)
      end
    end

    # http://www.alchemyapi.com/api/concept/htmlc.html
    post(:get_concepts_from_html) do |html, *args|
      options = args.first || {}
      uri "#{AlchemyApi.base_html_uri}/HTMLGetRankedConcepts"
      params :html => html,
             :maxRetrieve => options[:max_retrieve] || 10,
             :linkedData => 0,
             :showSourceText => options[:show_source_text] ? 1 : 0,
             :sourceText => options[:source_text] || 'cleaned_or_raw',
             :cquery => options[:cquery],
             :xpath => options[:xpath]
      handler do |response|
        AlchemyApi::ConceptTagging.get_concepts_handler(response)
      end
    end

    def self.get_concepts_handler(response)
      json = get_json(response)

      ConceptTaggingResult.new(json['concepts'], json['language'], json['url'], json['text'])
    end
  end
end
