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
end
