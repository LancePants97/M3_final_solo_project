require 'rails_helper'

RSpec.describe "BookSearchFacade" do
  describe "should call the facade and retrieve book search results" do
    before(:each) do
      town = "Denver,CO"

      @books = BookSearchFacade.get_books(town)
      
    end

    it "returns books based on a location search parameter" do
      expect(@books.count).to eq(5)
      
      @books.each do |book|
        # binding.pry
        expect(book.isbn).to be_an(Array)
      end


    end
  end
end