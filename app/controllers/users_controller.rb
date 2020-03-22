# frozen_string_literal: true

class UsersController < ApplicationController
  def top_commentators
    @commentators = User.top_last_7_days_commentators
  end
end
