class Api::V1::BooksController < ApplicationController
  def index
    town = params[:location]

    weather = ForecastFacade.get_current_forecast(town)
    
    book_info = BookSearchFacade.get_book_info(town)
    books = BookSearchFacade.get_books(town)
    book_forecast = BookSearchFacade.books_forecast(town, book_info, books, weather)

    render json: BookWeatherSerializer.book_weather_json(book_forecast)
  end
end