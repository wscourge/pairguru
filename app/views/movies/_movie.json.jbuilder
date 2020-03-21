json.data do
  json.id movie.id.to_s
  json.type Movie.name.downcase
  json.attributes do
    json.id movie.id.to_s
    json.title movie.title
    json.rating movie.rating
    json.plot movie.plot
    json.poster movie.poster
    json.created_at movie.created_at
    json.updated_at movie.updated_at
  end
  json.relationships do
    json.genre do
      json.data do
        json.id movie.genre.id.to_s
        json.type Genre.name.downcase
        json.attributes do
          json.id movie.genre.id.to_s
          json.name movie.genre.name
        end
      end
      json.meta do
        json.movies movie.genre.movies.size
      end
    end
  end
end
