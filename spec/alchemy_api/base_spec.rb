require File.dirname(__FILE__) + '/../spec_helper'

describe AlchemyApi::Base do
  describe "#check_json_for_errors_and_raise!" do
    before(:each) do
      @json = {
        'status' => 'ERROR',
        'url' => 'http://google.com',
        'statusInfo' => nil # replace in each test.
      }
    end

    it "should raise an error if the API key is invalid" do
      @json['statusInfo'] = 'invalid-api-key'
      lambda {
        AlchemyApi::Base.check_json_for_errors_and_raise!(@json)
      }.should raise_error(AlchemyApi::InvalidApiKeyError)
    end

    it "should raise an error if the page is not retrievable" do
      @json['statusInfo'] = 'cannot-retrieve'
      lambda {
        AlchemyApi::Base.check_json_for_errors_and_raise!(@json)
      }.should raise_error(AlchemyApi::CannotRetrieveUrlError)
    end

    it "should raise an error if the page is not valid HTML" do
      @json['statusInfo'] = 'page-is-not-html'
      lambda {
        AlchemyApi::Base.check_json_for_errors_and_raise!(@json)
      }.should raise_error(AlchemyApi::PageIsNotValidHtmlError)
    end

    it "should raise an error if the sent HTML was not valid" do
      @json['statusInfo'] = 'invalid-html'
      lambda {
        AlchemyApi::Base.check_json_for_errors_and_raise!(@json)
      }.should raise_error(AlchemyApi::InvalidHtmlError)
    end

    it "should raise an error if the content exceeds the max limit" do
      @json['statusInfo'] = 'content-exceeds-size-limit'
      lambda {
        AlchemyApi::Base.check_json_for_errors_and_raise!(@json)
      }.should raise_error(AlchemyApi::ContentExceedsMaxLimitError)
    end

    it "should raise an error if the content cannot be retrieve due to redirection limit" do
      @json['statusInfo'] = 'cannot-retrieve:http-redirect-limit'
      lambda {
        AlchemyApi::Base.check_json_for_errors_and_raise!(@json)
      }.should raise_error(AlchemyApi::RedirectionLimitError)
    end

    it "should raise an UnknownError if we get something we don't recognize" do
      @json['statusInfo'] = 'fdsafdsfdsafdskjldklfdad'
      lambda {
        AlchemyApi::Base.check_json_for_errors_and_raise!(@json)
      }.should raise_error(AlchemyApi::UnknownError)
    end
  end
end
