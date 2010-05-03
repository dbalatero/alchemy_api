require File.dirname(__FILE__) + "/../spec_helper"

describe AlchemyApi::TermExtraction do
  shared_examples_for 'a keyword ranker' do
    it "should return source text" do
      @result.source_text.should_not be_nil
    end

    it "should return 5 keywords" do
      @result.keywords.should have(5).things
    end

    it "should have relevance scores for the keywords" do
      @result.keywords.each do |kw|
        kw.relevance.should >= 0.0
        kw.relevance.should <= 1.0
      end
    end
  end

  typhoeus_spec_cache('spec/cache/term_extraction/get_ranked_keywords_from_html') do |hydra|
    describe "#get_ranked_keywords_from_html" do
      before(:each) do
        @url = "http://www.businessweek.com/news/2010-04-29/bp-spill-may-alter-obama-s-offshore-drilling-plans-update1-.html"
        @html = fixture_for('bp_spill.html')
        @result = AlchemyApi::TermExtraction.
          get_ranked_keywords_from_html(@html,
                                        :url => @url,
                                        :max_retrieve => 5,
                                        :show_source_text => true)
      end

      it_should_behave_like 'a keyword ranker'
    end
  end

  typhoeus_spec_cache('spec/cache/term_extraction/get_ranked_keywords_from_text') do |hydra|
    describe "#get_ranked_keywords_from_text" do
      before(:each) do
        @url = "http://test.com"
        text = fixture_for('article.txt')
        @result = AlchemyApi::TermExtraction.
          get_ranked_keywords_from_text(text,
                                        :url => @url,
                                        :max_retrieve => 5,
                                        :show_source_text => true)
      end

      it_should_behave_like 'a keyword ranker'
    end
  end

  typhoeus_spec_cache('spec/cache/term_extraction/get_ranked_keywords_from_url') do |hydra|
    describe "#get_ranked_keywords_from_url" do
      before(:each) do
        @url = 'http://www.businessweek.com/news/2010-05-02/bp-spill-threatens-gulf-of-mexico-oil-gas-operations-update1-.html'
        @result = AlchemyApi::TermExtraction.
          get_ranked_keywords_from_url(@url,
                                       :max_retrieve => 5,
                                       :show_source_text => true)
      end

      it "should return the given URL" do
        @result.url.should == @url
      end

      it_should_behave_like 'a keyword ranker'
    end
  end
end
