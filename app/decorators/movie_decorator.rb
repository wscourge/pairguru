# frozen_string_literal: true

class MovieDecorator < Draper::Decorator
  delegate_all

  def poster
    cached_api_response[:poster]
  end

  def plot
    cached_api_response[:plot]
  end

  def rating
    cached_api_response[:rating]
  end

  private

  def cached_api_response
    @cached_api_response ||= Rails.cache.fetch(cached_key, expires_in: 12.hours) do
      api_response
    end
  end

  def api_response
    @api_response ||= MovieApiService.new(title).adapt
  end

  def cached_key
    "#{cache_key_with_version}/movie/#{id}"
  end
end
