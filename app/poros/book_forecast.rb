class BookForecast
  attr_reader :town,
              :book_info,
              :book,
              :weather

  def initialize(town, book_info, book, weather)
    @town = town
    @book_info = book_info
    @book = book
    @weather = weather
  end
end