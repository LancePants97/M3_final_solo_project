class BookWeatherSerializer
  def self.book_weather_json(book_weather)
      {
        "data": {
          "id": nil,
          "type": "books",
          "attributes": {
            "destination": book_weather.town,
            "forecast": {
              "summary": book_weather.weather.condition,
              "temperature": "#{book_weather.weather.temperature} F"
            },
            "total_books_found": book_weather.book_info.total_books_found,
            "books": book_weather.book.map do |book|
              book_attrs_json(book)
            end
          }
        }
      }
    

  end

  def self.book_attrs_json(book)
    {
      "isbn": book.isbn,
      "title": book.title,
      "publisher": book.publisher
    }
  end
end