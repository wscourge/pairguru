# frozen_string_literal: true

require "rails_helper"

describe User, type: :model do
  it { is_expected.to allow_value("+48 999 888 777").for(:phone_number) }
  it { is_expected.to allow_value("48 999-888-777").for(:phone_number) }
  it { is_expected.to allow_value("48 999-888-777").for(:phone_number) }
  it { is_expected.not_to allow_value("+48 aaa bbb ccc").for(:phone_number) }
  it { is_expected.not_to allow_value("aaa +48 aaa bbb ccc").for(:phone_number) }
  it { is_expected.not_to allow_value("+48 999 888 777\naseasd").for(:phone_number) }

  describe ".top_last_7_days_commentators" do
    subject(:top) { described_class.top_last_7_days_commentators }

    let(:movies) { create_list(:movie, 12) }
    let(:users) { create_list(:user, 13) }

    before do
      # create one more comment for every next person of the first 10 people
      users[0..9].each.with_index do |user, index|
        movies[0..(index + 1)].each do |movie|
          create(:comment, user: user, movie: movie)
        end
      end
      # create all comments possible for the last person, yet older than 7 days
      movies.each do |movie|
        create(:comment, user: users[12], movie: movie, created_at: (7.days.ago - 1.second))
      end
    end

    it "does not take comments older than 7 days into account" do
      expect(top.map(&:id)).not_to include(12)
    end

    it "returns users sorted by comments count" do
      expect(top.count(&:id)).to eq(10)
      expect(top.map(&:comments_count)).to eq([*2..11].reverse)
    end

    it "returns users ids, names, emails and comments counts" do
      expect(top.first).to have_attributes(id: users[9].id,
                                           name: users[9].name,
                                           email: users[9].email,
                                           comments_count: 11)
      expect(top.fifth).to have_attributes(id: users[5].id,
                                           name: users[5].name,
                                           email: users[5].email,
                                           comments_count: 7)
    end
  end
end
