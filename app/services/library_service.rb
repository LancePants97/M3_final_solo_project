class LibraryService
  def self.find_books(town)
    conn = Faraday.new("https://openlibrary.org")

    fields = "title,isbn,publisher"
    location = town.split(",").first # remove state and comma so library search functions properly

    response = conn.get("/search.json") do |req|
      req.params[:title] = location
      req.params[:place] = location
      req.params[:fields] = fields
      req.params[:lang] = "eng"
      req.params[:limit] = 5
    end

    JSON.parse(response.body, symbolize_names: true)
  end
end