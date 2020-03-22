# frozen_string_literal: true

class MovieExporterJob < ApplicationJob
  queue_as :default

  def perform(user_id:, file_path:, **_args)
    MovieExporterService.new.call(file_path)
    MovieExportMailer.send_file(user_id, file_path).deliver_later
  end
end
