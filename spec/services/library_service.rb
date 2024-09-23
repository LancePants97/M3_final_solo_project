require "rails_helper"

RSpec.describe "Library Service" do
  describe "searches the library API for books and returns json with necessary attributes" do      
    before(:each) do
      town = "Denver,CO"
      @results = LibraryService.find_books(town)
    end

    it "contains necessary data in JSON" do
      expect(@results).to be_a(Hash)
      expect(@results).to have_key(:numFound)
      expect(@results[:docs][0]).to have_key(:isbn)
      expect(@results[:docs][0]).to have_key(:publisher)
      expect(@results[:docs][0]).to have_key(:title)
    end
  end
end