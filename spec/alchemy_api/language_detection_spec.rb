require File.dirname(__FILE__) + "/../spec_helper"

describe AlchemyApi::LanguageDetection do
  shared_examples_for 'a language detector' do
    it "should get a language" do
      @result.language.should_not be_nil
    end

    it "should get ISO codes" do
      @result.iso_639_1.should_not be_nil
      @result.iso_639_2.should_not be_nil
      @result.iso_639_3.should_not be_nil
    end

    it "should get the ethnologue URL" do
      @result.ethnologue_url.should_not be_nil
    end

    it "should get a native speaker count" do
      @result.native_speakers.should_not be_nil
    end

    it "should get a wikipedia URL" do
      @result.wikipedia_url.should_not be_nil
    end
  end

  typhoeus_spec_cache('spec/cache/language_detection/get_language_from_url') do |hydra|
    describe "#get_language_from_url" do
      before(:each) do
        @url = 'http://www.humboldtbrews.com/2010_index_music.htm'
        @result = AlchemyApi::LanguageDetection.
          get_language_from_url(@url,
                                :source_text => 'cleaned_or_raw')
      end

      it_should_behave_like 'a language detector'

      it "should get the URL" do
        @result.url.should == @url
      end
    end
  end

  typhoeus_spec_cache('spec/cache/language_detection/get_language_from_text') do |hydra|
    describe "#get_language_from_text" do
      before(:each) do
        @url = "http://test.com"
        text = fixture_for('article.txt')
        @result = AlchemyApi::LanguageDetection.
          get_language_from_text(text,
                                 :url => @url)
      end

      it_should_behave_like 'a language detector'
    end
  end

  typhoeus_spec_cache('spec/cache/language_detection/get_language_from_html') do |hydra|
    describe "#get_language_from_html" do
      before(:each) do
        @url = "http://www.businessweek.com/news/2010-04-29/bp-spill-may-alter-obama-s-offshore-drilling-plans-update1-.html"
        @html = fixture_for('bp_spill.html')
        @result = AlchemyApi::LanguageDetection.
          get_language_from_html(@html, :url => @url,
                                 :source_text => 'cleaned_or_raw')
      end

      it_should_behave_like 'a language detector'
    end
  end
end
