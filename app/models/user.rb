# == Schema Information
#
# Table name: users
#
#  id                     :integer          not null, primary key
#  email                  :string           default(""), not null
#  encrypted_password     :string           default(""), not null
#  reset_password_token   :string
#  reset_password_sent_at :datetime
#  remember_created_at    :datetime
#  sign_in_count          :integer          default("0"), not null
#  current_sign_in_at     :datetime
#  last_sign_in_at        :datetime
#  current_sign_in_ip     :string
#  last_sign_in_ip        :string
#  created_at             :datetime
#  updated_at             :datetime
#

class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable, :confirmable

  has_many :comments

  validates :phone_number, format: { with: /\A[+]?\d+(?>[- .]\d+)*\z/, allow_nil: true }

  class << self
    def top_last_7_days_commentators
      joins(:comments)
        .where("comments.created_at >= :start", start: 7.days.ago)
        .where("comments.created_at <= :end", end: Time.zone.now)
        .select(:id, :name, :email, "count(comments) as comments_count")
        .group(:id)
        .order(comments_count: :desc)
        .limit(10)
    end
  end
end
