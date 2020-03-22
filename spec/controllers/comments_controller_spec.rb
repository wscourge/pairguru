# frozen_string_literal: true

require "rails_helper"

describe CommentsController, type: :controller do
  let(:user) { nil }
  let(:movie) { nil }
  let(:comment) { nil }

  before { allow(controller).to receive(:current_user).and_return(user) }

  describe "POST #create" do
    subject { response }

    let(:params) { { movie_id: movie&.id, content: FFaker::Lorem.paragraph(3), format: :js } }

    before do
      user
      movie
      comment
      post :create, params: params
    end

    context "when user does not exist" do
      let(:movie) { create(:movie) }

      it { is_expected.to have_http_status(:not_found) }
    end

    context "when movie does not exist" do
      let(:user) { create(:user) }

      it { is_expected.to have_http_status(:not_found) }
    end

    context "when comment does not exist" do
      let(:user) { create(:user) }
      let(:movie) { create(:movie) }

      it { is_expected.to have_http_status(:ok) }
    end

    context "when comment already exists" do
      let(:user) { create(:user) }
      let(:movie) { create(:movie) }
      let(:comment) { create(:comment, user: user, movie: movie) }

      it { is_expected.to have_http_status(:conflict) }
    end
  end

  describe "DELETE #destroy" do
    subject { response }

    let(:params) { { movie_id: movie&.id, format: :js } }

    before do
      user
      movie
      comment
      delete :destroy, params: params
    end

    context "when user does not exist" do
      let(:movie) { create(:movie) }

      it { is_expected.to have_http_status(:not_found) }
    end

    context "when movie does not exist" do
      let(:user) { create(:user) }

      it { is_expected.to have_http_status(:not_found) }
    end

    context "when comment does not exist" do
      let(:user) { create(:user) }
      let(:movie) { create(:movie) }

      it { is_expected.to have_http_status(:not_found) }
    end

    context "when comment exists" do
      let(:user) { create(:user) }
      let(:movie) { create(:movie) }
      let(:comment) { create(:comment, user: user, movie: movie) }

      it { is_expected.to have_http_status(:ok) }
    end
  end
end
