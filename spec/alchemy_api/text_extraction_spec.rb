require File.dirname(__FILE__) + "/../spec_helper"

describe AlchemyApi::TextExtraction do
  shared_examples_for 'error handler' do
    before(:each) do
      @response = mock('response')
      @response.stub!(:code).and_return(200)
      @json = {
        'status' => 'ERROR',
        'url' => 'http://google.com',
        'statusInfo' => nil # replace in each test.
      }
    end

    it "should raise an error if the API key is invalid" do
      @json['statusInfo'] = 'invalid-api-key'
      @response.stub!(:body).and_return(@json.to_json)
      lambda {
        AlchemyApi::TextExtraction.send(@method, @response)
      }.should raise_error(AlchemyApi::InvalidApiKeyError)
    end

    it "should raise an error if the page is not retrievable" do
      @json['statusInfo'] = 'cannot-retrieve'
      @response.stub!(:body).and_return(@json.to_json)
      lambda {
        AlchemyApi::TextExtraction.send(@method, @response)
      }.should raise_error(AlchemyApi::CannotRetrieveUrlError)
    end

    it "should raise an error if the page is not valid HTML" do
      @json['statusInfo'] = 'page-is-not-html'
      @response.stub!(:body).and_return(@json.to_json)
      lambda {
        AlchemyApi::TextExtraction.send(@method, @response)
      }.should raise_error(AlchemyApi::PageIsNotValidHtmlError)
    end

    it "should raise an error if the sent HTML was not valid" do
      @json['statusInfo'] = 'invalid-html'
      @response.stub!(:body).and_return(@json.to_json)
      lambda {
        AlchemyApi::TextExtraction.send(@method, @response)
      }.should raise_error(AlchemyApi::InvalidHtmlError)
    end

    it "should raise an error if the content exceeds the max limit" do
      @json['statusInfo'] = 'content-exceeds-size-limit'
      @response.stub!(:body).and_return(@json.to_json)
      lambda {
        AlchemyApi::TextExtraction.send(@method, @response)
      }.should raise_error(AlchemyApi::ContentExceedsMaxLimitError)
    end

    it "should raise an error if the content cannot be retrieve due to redirection limit" do
      @json['statusInfo'] = 'cannot-retrieve:http-redirect-limit'
      @response.stub!(:body).and_return(@json.to_json)
      lambda {
        AlchemyApi::TextExtraction.send(@method, @response)
      }.should raise_error(AlchemyApi::RedirectionLimitError)
    end
  end

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


  describe "#get_title_from_url_handler" do
    describe "error handling" do
      before(:each) do
        @method = :get_title_from_url_handler
      end

      it_should_behave_like 'error handler'
    end
  end

  describe "#get_text_from_url_handler" do
    describe "error handling" do
      before(:each) do
        @method = :get_text_from_url_handler
      end
      it_should_behave_like 'error handler'
    end
  end
end
