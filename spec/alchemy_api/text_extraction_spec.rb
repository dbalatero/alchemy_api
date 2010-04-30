require File.dirname(__FILE__) + "/../spec_helper"

describe AlchemyApi::TextExtraction do
  typhoeus_spec_cache('spec/cache/text_extraction/get_text_from_url') do |hydra|
    describe "#get_text_from_url" do
      it "should extract text" do
        url = "http://www.chron.com/disp/story.mpl/business/6981685.html"
        result = AlchemyApi::TextExtraction.get_text_from_url(url)

        result.url.should == url
        result.text.should_not be_empty
      end
    end
  end

  typhoeus_spec_cache('spec/cache/text_extraction/get_raw_text_from_url') do |hydra|
    describe "#get_raw_text_from_url" do
      before(:each) do
        @url = "http://www.chron.com/disp/story.mpl/business/6981685.html"
        @result = AlchemyApi::TextExtraction.get_raw_text_from_url(@url)
      end

      it "should extract url" do
        @result.url.should == @url
      end

      it "should get text back" do
        @result.text.should_not be_empty
      end
    end
  end

  typhoeus_spec_cache('spec/cache/text_extraction/get_title_from_url') do |hydra|
    describe "#get_title_from_url" do
      before(:each) do
        @url = "http://www.businessweek.com/news/2010-04-29/bp-spill-may-alter-obama-s-offshore-drilling-plans-update1-.html"
        @result = AlchemyApi::TextExtraction.get_title_from_url(@url)
      end

      it "should extract url" do
        @result.url.should == @url
      end

      it "should get text back" do
        @result.title.should =~ /BP Spill/
      end
    end
  end

  typhoeus_spec_cache('spec/cache/text_extraction/get_title_from_html') do |hydra|
    describe "#get_title_from_html" do
      before(:each) do
        @url = "http://www.businessweek.com/news/2010-04-29/bp-spill-may-alter-obama-s-offshore-drilling-plans-update1-.html"
        @html = fixture_for('bp_spill.html')
        @result = AlchemyApi::TextExtraction.
          get_title_from_html(@html, :url => @url)
      end

      it "should get title back" do
        @result.title.should =~ /BP Spill/
      end
    end
  end

  typhoeus_spec_cache('spec/cache/text_extraction/get_raw_text_from_html') do |hydra|
    describe "#get_raw_text_from_html" do
      before(:each) do
        @url = "http://www.businessweek.com/news/2010-04-29/bp-spill-may-alter-obama-s-offshore-drilling-plans-update1-.html"
        @html = fixture_for('bp_spill.html')
        @result = AlchemyApi::TextExtraction.
          get_raw_text_from_html(@html, :url => @url)
      end

      it "should get text back" do
        @result.text.should_not be_empty
      end
    end
  end

  typhoeus_spec_cache('spec/cache/text_extraction/get_text_from_html') do |hydra|
    describe "#get_text_from_html" do
      before(:each) do
        @url = "http://www.businessweek.com/news/2010-04-29/bp-spill-may-alter-obama-s-offshore-drilling-plans-update1-.html"
        @html = fixture_for('bp_spill.html')
        @result = AlchemyApi::TextExtraction.
          get_text_from_html(@html, :url => @url)
      end

      it "should get text back" do
        @result.text.should_not be_empty
      end
    end
  end
end
