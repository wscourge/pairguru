require "rails_helper"

describe "Genres requests", type: :request do
  let!(:genres) { create_list(:genre, 5, :with_movies) }
  let(:user) { create(:user) }

  before { allow_any_instance_of(GenresController).to receive(:current_user).and_return(user) }

  describe "genre list" do
    it "displays only related movies" do
      visit "/genres/" + genres.sample.id.to_s + "/movies"
      expect(page).to have_selector("table tr", count: 5)
    end
  end
end
