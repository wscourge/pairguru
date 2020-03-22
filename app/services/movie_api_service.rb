# frozen_string_literal: true

class MovieApiService
  SERVICE_DOMAIN = "https://pairguru-api.herokuapp.com"
  SERVICE_ENDPOINT = "/api/v1/movies/"
  API_URL = "#{SERVICE_DOMAIN}#{SERVICE_ENDPOINT}"
  DEFAULTS = { poster: "", plot: "", rating: 0.0 }.freeze
  NO_MOVIE_MSG = "Couldn't find Movie"

  def initialize(title)
    @title = ERB::Util.url_encode(title)
  end

  def adapt
    return DEFAULTS if invalid_response?

    parsed_response.dig(:data, :attributes).tap do |attributes|
      attributes[:poster] = "#{SERVICE_DOMAIN}#{attributes[:poster]}"
    end
  rescue StandardError => e
    Rails.logger.warn("#{self.class.name}/#{e.class.name}: #{e.message}")
    DEFAULTS
  end

  private

  def invalid_response?
    response.code > 299 || parsed_response[:message] == NO_MOVIE_MSG
  end

  def parsed_response
    @parsed_response ||= JSON.parse(response.body).with_indifferent_access
  end

  def response
    @response ||= HTTParty.get("#{API_URL}#{@title}")
  end
end
