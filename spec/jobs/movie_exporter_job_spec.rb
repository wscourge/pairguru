# frozen_string_literal: true

require "rails_helper"

RSpec.describe MovieExporterJob, type: :job do
  include ActiveJob::TestHelper

  let(:csv_exporter) { instance_double(MovieExporterService) }
  let(:mailer) { class_double(MovieExportMailer).as_stubbed_const }
  let(:email_delivery) { instance_double(ActionMailer::MessageDelivery) }

  before do
    allow(MovieExporterService).to receive(:new).and_return(csv_exporter)
    allow(csv_exporter).to receive(:call)
    allow(mailer).to receive(:send_file).and_return(email_delivery)
    allow(email_delivery).to receive(:deliver_later)
  end

  describe "#perform_later" do
    subject(:perform) { described_class.perform_later(user_id: user_id, file_path: file_path) }

    let(:user_id) { 1 }
    let(:file_path) { "tmp/movies.csv" }

    it "enqueues job" do
      ActiveJob::Base.queue_adapter = :test
      perform
      expect(described_class).to have_been_enqueued.exactly(:once)
    end

    it "exports csv and sends email" do
      ActiveJob::Base.queue_adapter = :test
      perform_enqueued_jobs { perform }
      expect(csv_exporter).to have_received(:call).with(file_path).once
      expect(mailer).to have_received(:send_file).with(user_id, file_path).once
      expect(email_delivery).to have_received(:deliver_later).once
    end
  end
end
