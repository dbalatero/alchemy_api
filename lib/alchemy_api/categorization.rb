module AlchemyApi
  Category = Struct.new(:url, :name, :score)

  class Categorization < Base
    post(:get_categorization_from_text) do |text, *args|
      options = args.first || {}
      uri "#{AlchemyApi.base_text_uri}/TextGetCategory"
      params :text => text,
             :url => options[:url] || ''
      handler do |response|
        AlchemyApi::Categorization.get_categorization_handler(response)
      end
    end

    post(:get_categorization_from_url) do |url, *args|
      options = args.first || {}
      uri "#{AlchemyApi.base_uri}/URLGetCategory"
      params :url => url,
             :cquery => options[:cquery] || '',
             :sourceText => options[:source_text] || 'cleaned_or_raw',
             :xpath => options[:xpath] || ''
      handler do |response|
        AlchemyApi::Categorization.get_categorization_handler(response)
      end
    end


    post(:get_categorization_from_html) do |html, *args|
      options = args.first || {}
      uri "#{AlchemyApi.base_html_uri}/HTMLGetCategory"
      params :html => html,
             :url => options[:url] || '',
             :cquery => options[:cquery] || '',
             :sourceText => options[:source_text] || 'cleaned_or_raw',
             :xpath => options[:xpath] || ''
      handler do |response|
        AlchemyApi::Categorization.get_categorization_handler(response)
      end
    end

    def self.get_categorization_handler(response)
      json = get_json(response)
      Category.new(json['url'], json['category'],
                   json['score'].to_f)
    end
  end
end
