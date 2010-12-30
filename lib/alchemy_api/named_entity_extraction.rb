module AlchemyApi
  Entity = Struct.new(:text, :type, :relevance, :count)
  NamedEntitiesResult = Struct.new(:entities, :language, :url, :source_text)

  class NamedEntityExtraction < Base

    post(:get_named_entities_from_text) do |text, *args|
      options = args.first || {}
      uri "#{AlchemyApi.base_text_uri}/TextGetRankedNamedEntities"
      params  :text => text,
              :url => options[:url],
              :maxRetrieve => options[:max_retrieve] || 10,
              :showSourceText => options[:show_source_text] ? 1 : 0
      handler do |response|
        AlchemyApi::NamedEntityExtraction.get_ranked_entities_handler(response)
      end
    end

    def self.get_ranked_entities_handler(response)
      json = get_json(response)
      entities = json['entities'].each do |e|
        Entity.new(e['text'], e['type'], e['relevance'].to_f, e['count'])
      end
      NamedEntitiesResult.new(entities, json['language'],
                               json['url'], json['text'])
    end
  end
end
