# frozen_string_literal: true

shared_examples "movie json" do
  let(:data) { received["data"] }
  let(:attributes) { data["attributes"] }
  let(:relationships) { data["relationships"] }

  it "renders correct types" do
    expect(data["id"]).to be_kind_of(String)
    expect(attributes["id"]).to be_kind_of(String)
    expect(relationships["genre"]["data"]["id"]).to be_kind_of(String)
    expect(relationships["genre"]["data"]["attributes"]["id"]).to be_kind_of(String)
  end

  it "renders correct attributes" do
    expect(attributes["title"]).to eq(movie.title)
    expect(attributes["poster"]).to eq(movie.poster)
    expect(attributes["rating"]).to eq(movie.rating)
    expect(attributes["plot"]).to eq(movie.plot)
  end

  it "renders correct relationships" do
    expect(relationships["genre"]["data"]["attributes"]["name"]).to eq(genre.name)
    expect(relationships["genre"]["meta"]["movies"]).to eq(genre.movies.size)
  end
end
