class BookInfo
  attr_reader :total_books_found

  def initialize(book)
    @total_books_found = book[:numFound]
  end
end