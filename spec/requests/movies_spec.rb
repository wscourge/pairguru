require "rails_helper"

describe "Movies requests", type: :request do
  describe "index view" do
    it "displays right title" do
      visit "/movies"
      expect(page).to have_selector("h1", text: "Movies")
    end
  end

  describe "JSON API", type: :request do
    let(:genre) { create(:genre, :with_movies) }
    let(:movies) { genre.movies.decorate }
  
    before { genre }
  
    describe "GET index" do
      subject(:rendered) do
        get "/movies.json"
        JSON.parse(response.body)
      end
  
      it "renders correct type" do
        expect(rendered).to be_kind_of(Array)
      end
  
      describe "first movie" do
        let(:received) { rendered.first }
        let(:movie) { movies.first }
  
        it_behaves_like "movie json"
      end
  
      describe "second movie" do
        let(:received) { rendered.second }
        let(:movie) { movies.second }
  
        it_behaves_like "movie json"
      end
    end
  
    describe "GET show" do
      subject(:rendered) do
        get "/movies/#{movies.first.id}.json"
        JSON.parse(response.body)
      end
  
      let(:received) { rendered }
      let(:movie) { movies.first }
  
      it_behaves_like "movie json"
    end
  end
end

