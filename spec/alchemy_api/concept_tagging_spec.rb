require File.dirname(__FILE__) + "/../spec_helper"

describe AlchemyApi::ConceptTagging do
  typhoeus_spec_cache('spec/cache/concept_tagging/get_concepts_from_text') do |hydra|
    describe "#get_concepts_from_text" do
      before(:each) do
        @url = "http://test.com"
        text = fixture_for('article.txt')

        @results = AlchemyApi::ConceptTagging.
          get_concepts_from_text(text)
      end

      it "should return at least one concept" do
        @results.concepts.should_not be_empty
      end
    end
  end

  typhoeus_spec_cache('spec/cache/concept_tagging/get_concepts_from_url') do |hydra|
    describe "#get_concepts_from_url" do
      before(:each) do
        @url = 'http://www.macrumors.com/2010/04/30/apples-discontinuation-of-lala-streaming-music-service-not-likely-leading-to-imminent-launch-of-web-focused-itunes/'
        @results = AlchemyApi::ConceptTagging.
          get_concepts_from_url(@url,
                                      :source_text => 'cleaned_or_raw')
      end
  
      it "should return at least one concept" do
        @results.concepts.should_not be_empty
      end
    end
  end
  
  typhoeus_spec_cache('spec/cache/concept_tagging/get_concepts_from_html') do |hydra|
    describe "#get_concepts_from_html" do
      before(:each) do
        @url = "http://www.businessweek.com/news/2010-04-29/bp-spill-may-alter-obama-s-offshore-drilling-plans-update1-.html"
        @html = fixture_for('bp_spill.html')
        @results = AlchemyApi::ConceptTagging.
          get_concepts_from_html(@html, :url => @url,
                                       :source_text => 'cleaned_or_raw')
      end
  
      it "should return at least one concept" do
        @results.concepts.should_not be_empty
      end
    end
  end
end
