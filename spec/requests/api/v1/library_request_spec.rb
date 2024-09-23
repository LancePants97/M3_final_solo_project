require 'rails_helper'

RSpec.describe 'Open Library Request', type: :request do
  before(:each) do
    location = "Denver,CO"

    get "/api/v1/book-search?location=denver,co&quantity=5"

    @results = JSON.parse(response.body, symbolize_names: true)[:data]
  end

  it "returns a properly formatted JSON of book and weather forecast results when given a location" do
    expect(@results[:id]).to eq(nil)
    expect(@results[:type]).to eq("books")
    expect(@results[:attributes]).to be_a(Hash)

    expect(@results[:attributes]).to have_key(:destination)
    expect(@results[:attributes][:destination]).to eq("denver,co")

    expect(@results[:attributes]).to have_key(:forecast)
    expect(@results[:attributes][:forecast]).to be_a(Hash)

    expect(@results[:attributes][:forecast]).to have_key(:summary)
    expect(@results[:attributes][:forecast][:summary]).to be_a(String)

    expect(@results[:attributes][:forecast]).to have_key(:temperature)
    expect(@results[:attributes][:forecast][:temperature]).to be_a(String)
    expect(@results[:attributes][:forecast][:temperature]).to include(" F")

    expect(@results[:attributes]).to have_key(:total_books_found)
    expect(@results[:attributes][:total_books_found]).to be_an(Integer)

    expect(@results[:attributes]).to have_key(:books)
    expect(@results[:attributes][:books]).to be_an(Array)

    books = @results[:attributes][:books]
    expect(books.count).to eq(5)

    books.each do |book|
      expect(book[:isbn]).to be_an(Array)
      expect(book[:isbn].first).to be_a(String)

      expect(book[:title]).to be_a(String)

      expect(book[:publisher]).to be_an(Array)
      expect(book[:publisher].first).to be_a(String)
    end
  end
end