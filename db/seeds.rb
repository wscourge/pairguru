require "ffaker"

Rails.logger = Logger.new(STDOUT)

Rails.logger.info "Creating users..."

20.times do |i|
  name = FFaker::Name.first_name
  email = FFaker::Internet.email
  next if User.exists?(email: email)

  User.create!(
    email: email,
    name: name,
    confirmed_at: Time.zone.now,
    password: "password"
  )
end

Rails.logger.info "Creating genres..."

%w(Action Comedy Sci-Fi War Crime
   Horror Sport Western Drama
   Musicial Romance Thriller).each do |genre|
  Genre.find_or_create_by!(name: genre)
end

movies = [
  {
    title: "Pulp Fiction",
    release_year: "1994"
  },
  {
    title: "Django",
    release_year: "2012"
  },
  {
    title: "Kill Bill",
    release_year: "2003"
  },
  {
    title: "Kill Bill 2",
    release_year: "2004"
  },
  {
    title: "Inglourious Basterds",
    release_year: "2009"
  },
  {
    title: "Godfather",
    release_year: "1972"
  },
  {
    title: "The Dark Knight",
    release_year: "2008"
  },
  {
    title: "Star Wars V",
    release_year: "1980"
  },
  {
    title: "Inception",
    release_year: "2010"
  },
  {
    title: "Deadpool",
    release_year: "2016"
  }
]

Rails.logger.info "Creating movies..."

genre_ids = Genre.pluck(:id)
if Movie.count < 100
  100.times do
    movie = movies.sample
    Movie.create!(
      title: movie[:title],
      description: FFaker::Lorem.paragraph(5),
      genre_id: genre_ids.sample,
      released_at: Date.new(movie[:release_year].to_i)
    )
  end
end

Rails.logger.info "Creating comments..."

movies_ids = [*1..100]
users_ids = [*1..20]
comments = []
if Comment.count < 2000
  users_ids.each do |user_id|
    movies_ids.each do |movie_id|
      timestamp = FFaker::Time.between(13.days.ago, Time.now)
      comments << {
        movie_id: movie_id,
        user_id: user_id,
        content: FFaker::CheesyLingo.sentence,
        created_at: timestamp,
        updated_at: timestamp
      }
    end
  end
  Comment.insert_all(comments)
end
