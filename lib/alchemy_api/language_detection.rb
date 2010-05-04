module AlchemyApi
  LanguageResult = Struct.new(:url, :language, :iso_639_1, :iso_639_2,
                              :iso_639_3, :ethnologue_url,
                              :native_speakers, :wikipedia_url)

  class LanguageDetection < Base
    post(:get_language_from_url) do |url, *args|
      options = args.first || {}
      uri "#{AlchemyApi.base_uri}/URLGetLanguage"
      params :url => url,
             :sourceText => options[:source_text] || 'cleaned_or_raw',
             :cquery => options[:cquery],
             :xpath => options[:xpath]
      handler do |response|
        AlchemyApi::LanguageDetection.get_language_handler(response)
      end
    end

    post(:get_language_from_html) do |html, *args|
      options = args.first || {}
      uri "#{AlchemyApi.base_html_uri}/HTMLGetLanguage"
      params :html => html,
             :url => options[:url],
             :sourceText => options[:source_text] || 'cleaned_or_raw',
             :cquery => options[:cquery],
             :xpath => options[:xpath]
      handler do |response|
        AlchemyApi::LanguageDetection.get_language_handler(response)
      end
    end

    post(:get_language_from_text) do |text, *args|
      options = args.first || {}
      uri "#{AlchemyApi.base_text_uri}/TextGetLanguage"
      params :text => text,
             :url => options[:url]
      handler do |response|
        AlchemyApi::LanguageDetection.get_language_handler(response)
      end
    end

    def self.get_language_handler(response)
      json = get_json(response)
      LanguageResult.new(json['url'], json['language'], json['iso-639-1'],
                         json['iso-639-2'], json['iso-639-3'],
                         json['ethnologue'],
                         json['native-speakers'],
                         json['wikipedia'])
    end
  end
end
