# frozen_string_literal: true

describe MovieInfoMailer, type: :mailer do
  describe "#send_info" do
    subject(:send_info) { described_class.send_info(user.id, movie.id) }

    let(:user) { create(:user) }
    let(:movie) { create(:movie, title: "A Clockwork Orange") }

    before { send_info }

    it "has correct subject" do
      expect(send_info.subject).to eq("Info about movie A Clockwork Orange")
    end

    it "has correct from" do
      expect(send_info.from).to eq(["from@example.com"])
    end

    it "has correct to" do
      expect(send_info.to).to eq([user.email])
    end

    it "contains movie title" do
      expect(send_info.body.encoded).to match("A Clockwork Orange")
    end
  end
end
