# frozen_string_literal: true

class CommentsController < ApplicationController
  before_action :user, only: %i[create destroy]
  before_action :movie, only: %i[create destroy]
  rescue_from ActiveRecord::RecordNotFound, with: :not_found

  def create
    render(status: :conflict) && return if Comment.exists?(user: @user, movie: @movie)
    @comment = Comment.new(user: @user, movie: @movie, content: params[:content])
    @comment.save
  end

  def destroy
    @comment = Comment.find_by!(user: @user, movie: @movie).destroy
  end

  private

  def user
    @user ||= User.find(current_user&.id)
  end

  def movie
    @movie ||= Movie.find(params[:movie_id])
  end

  def not_found
    render status: :not_found
  end
end
