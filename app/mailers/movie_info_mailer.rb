# frozen_string_literal: true

class MovieInfoMailer < ApplicationMailer
  def send_info(user_id, movie_id)
    sleep(Rails.env.test? ? 0 : 3) # this emulates long email sending, do not remove
    @user = User.find(user_id)
    @movie = Movie.find(movie_id)

    mail(to: @user.email, subject: "Info about movie #{@movie.title}")
  rescue ActiveRecord::RecordNotFound => e
    Rails.logger.warn("#{self.class.name}/#{e.class}: #{e.message}")
  end
end
