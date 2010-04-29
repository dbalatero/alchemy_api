require File.dirname(__FILE__) + '/spec_helper'

describe AlchemyApi do
  describe "#api_key" do
    it "should be settable" do
      AlchemyApi.api_key = "fdsa"
      AlchemyApi.api_key.should == 'fdsa'
    end
  end
end
