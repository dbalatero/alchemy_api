module AlchemyApi
  EntityResult = Struct.new(:language, :url, :text, :entities)
  Quotation = Struct.new(:body)
  Entity = Struct.new(:type, :relevance, :count, :text,
                      :disambiguation, :quotations)
  Disambiguation = Struct.new(:name, :sub_type, :website, :geo,
                              :dbpedia, :yago, :opencyc, :umbel,
                              :freebase, :cia_factbook, :census,
                              :geonames, :music_brainz, :crunchbase,
                              :semantic_crunchbase)

  class Disambiguation
    def new_from_json(json)
      disambiguation = Disambiguation.new
      disambiguation.name = json['name']
      disambiguation.sub_type = json['subType']
      disambiguation.website = json['website']
      disambiguation.geo = json['geo']
      disambiguation.dbpedia = json['dbpedia']
      disambiguation.yago = json['yago']
      disambiguation.opencyc = json['opencyc']
      disambiguation.umbel = json['umbel']
      disambiguation.freebase = json['freebase']
      disambiguation.cia_factbook = json['ciaFactbook']
      disambiguation.census = json['census']
      disambiguation.geonames = json['geonames']
      disambiguation.music_brainz = json['music_brainz']
      disambiguation.crunchbase = json['crunchbase']
      disambiguation.semantic_crunchbase = json['semantic_crunchbase']
    end
  end

  class EntityExtraction < Base

    def self.get_entities_handler(response)
      json = get_json(response)

      pp json.inspect
      abort

      result = EntityResult.new(json['language'], json['url'],
                                json['text'], entities)
    end
  end
end
