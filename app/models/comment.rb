# frozen_string_literal: true

require "composite_primary_keys"

class Comment < ApplicationRecord
  self.primary_keys = :user_id, :movie_id
  belongs_to :user
  belongs_to :movie

  delegate :name, to: :user, prefix: true
end
