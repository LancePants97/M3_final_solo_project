class BookSearchFacade
  def self.get_books(town)
    books = LibraryService.find_books(town)
    
    books[:docs].map do |book|
      Book.new(book)
    end
  end

  def self.get_book_info(town)
    books = LibraryService.find_books(town)
    BookInfo.new(books)
  end

  def self.books_forecast(town, book_info, books, forecast)
    BookForecast.new(town, book_info, books, forecast)
  end
end