# frozen_string_literal: true

describe MovieExportMailer, type: :mailer do
  describe "#send_file" do
    subject(:send_file) { described_class.send_file(user.id, file_path) }

    let(:file_path) { "tmp/movies.csv" }
    let(:user) { create(:user) }
    let(:csv) { "such;a;cool;csv\ndont;you;think;so\n" }

    before { send_file }

    it "has correct subject" do
      expect(send_file.subject).to eq("Your export is ready")
    end

    it "has correct from" do
      expect(send_file.from).to eq(["from@example.com"])
    end

    it "has correct to" do
      expect(send_file.to).to eq([user.email])
    end

    it "has attached csv" do
      expect(send_file.attachments["movies.csv"]).to be_kind_of(Mail::Part)
    end

    it "contains movie title" do
      expect(send_file.body.encoded).to match("CSV in attachment.")
    end
  end
end
