# frozen_string_literal: true

require "rails_helper"

describe MovieApiService do
  describe "#initialize" do
    subject(:adapter) { described_class.new("The Dark Knight") }

    it { expect(adapter.instance_variable_get(:@title)).to eq("The%20Dark%20Knight") }
  end

  describe "#adapt" do
    subject(:adapted) { described_class.new("37°2 le matin").adapt }

    let(:response) { instance_double(HTTParty::Response) }

    before do
      allow(response).to receive(:code).and_return(200)
      allow(HTTParty).to receive(:get).and_return(response)
    end

    context "with valid response" do
      before { allow(response).to receive(:body).and_return(response_body_string) }

      context "when movie exists" do
        let(:response_body_hash) do
          {
            data: {
              attributes: {
                poster: "/37-le-matin.jpg",
                plot: 'Leading a peaceful life, Zorg meets the energetic Betty with whom he lives.
After a while, he begins to notice that his beloved is behaving more and more strangely.',
                rating: 9.0
              }
            }
          }
        end
        let(:response_body_string) { response_body_hash.to_json }

        it { expect(adapted[:plot]).to eq(response_body_hash[:data][:attributes][:plot]) }
        it { expect(adapted[:rating]).to eq(response_body_hash[:data][:attributes][:rating]) }
        it { expect(adapted[:poster]).to end_with(response_body_hash[:data][:attributes][:poster]) }
      end

      context "when movie does not exist" do
        let(:response_body_string) { { message: "Couldn't find Movie" }.to_json }

        it { is_expected.to eq({ poster: "", plot: "", rating: 0.0 }) }
      end
    end

    context "with invalid response" do
      context "with HTTP code other than success" do
        before { allow(response).to receive(:code).and_return(400) }

        it { is_expected.to eq({ poster: "", plot: "", rating: 0.0 }) }
      end

      context "when error is raised" do
        before { allow(HTTParty).to receive(:get).and_raise(HTTParty::Error) }

        it { is_expected.to eq({ poster: "", plot: "", rating: 0.0 }) }
      end
    end
  end
end
