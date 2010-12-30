require File.dirname(__FILE__) + "/../spec_helper"

describe AlchemyApi::NamedEntityExtraction do

  typhoeus_spec_cache('spec/cache/named_entity_extraction/get_named_entity_text') do |hydra|
    describe "#get_named_entities_from_text" do
      before(:each) do
        @url = "http://test.com"
        text = fixture_for('article.txt')
        @result = AlchemyApi::NamedEntityExtraction.
          get_named_entities_from_text(text,
                                        :url => @url,
                                        :max_retrieve => 5,
                                        :show_source_text => true)
      end

      it "should return at least one entity" do
        @results.entites.should_not be_empty
      end
    end
  end

end

