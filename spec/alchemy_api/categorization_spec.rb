require File.dirname(__FILE__) + "/../spec_helper"

describe AlchemyApi::Categorization do
  typhoeus_spec_cache('spec/cache/categorization/get_categorization_from_text') do |hydra|
    describe "#get_categorization_from_text" do
      before(:each) do
        @url = "http://test.com"
        text = fixture_for('article.txt')

        @category = AlchemyApi::Categorization.
          get_categorization_from_text(text)
      end

      it "should return a category name" do
        @category.name.should_not be_nil
      end
    end
  end

  typhoeus_spec_cache('spec/cache/categorization/get_categorization_from_url') do |hydra|
    describe "#get_categorization_from_url" do
      before(:each) do
        @url = 'http://www.macrumors.com/2010/04/30/apples-discontinuation-of-lala-streaming-music-service-not-likely-leading-to-imminent-launch-of-web-focused-itunes/'
        @category = AlchemyApi::Categorization.
          get_categorization_from_url(@url,
                                      :source_text => 'cleaned_or_raw')
      end

      it "should return a category name" do
        @category.name.should_not be_nil
      end

      it "should return a url" do
        @category.url.should_not be_nil
      end
    end
  end

  typhoeus_spec_cache('spec/cache/categorization/get_categorization_from_html') do |hydra|
    describe "#get_categorization_from_html" do
      before(:each) do
        @url = "http://www.businessweek.com/news/2010-04-29/bp-spill-may-alter-obama-s-offshore-drilling-plans-update1-.html"
        @html = fixture_for('bp_spill.html')
        @category = AlchemyApi::Categorization.
          get_categorization_from_html(@html, :url => @url,
                                       :source_text => 'cleaned_or_raw')
      end

      it "should return a category" do
        @category.name.should_not be_nil
      end
    end
  end
end
