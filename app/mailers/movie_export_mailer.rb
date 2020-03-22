# frozen_string_literal: true

class MovieExportMailer < ApplicationMailer
  def send_file(user_id, file_path)
    @user = User.find(user_id)
    return if @user.blank?

    attachments["movies.csv"] = File.read(file_path)
    mail(to: @user.email, subject: "Your export is ready")
  rescue ActiveRecord::RecordNotFound => e
    Rails.logger.warn("#{self.class.name}/#{e.class}: #{e.message}")
  end
end
