module AlchemyApi
  Category = Struct.new(:url, :name, :score)

  class Categorization < Base
    post(:get_categorization_from_text) do |text, *args|
      options = args.first || {}
      uri "#{AlchemyApi.base_text_uri}/TextGetCategory"
      params :apikey => AlchemyApi.api_key,
             :text => text,
             :url => options[:url] || '',
             :outputMode => 'json'
      handler do |response|
        AlchemyApi::Categorization.get_categorization_handler(response)
      end
    end

    def self.get_categorization_handler(response)
      json = JSON.parse(response.body)
      check_json_for_errors_and_raise!(json)
      Category.new(json['url'], json['category'],
                   json['score'].to_f)
    end
  end
end
