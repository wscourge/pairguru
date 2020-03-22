# frozen_string_literal: true

describe MovieDecorator do
  let(:movie) { create(:movie).decorate }
  let(:adapter) { instance_double(MovieApiService) }
  let(:adapted) do
    {
      poster: "/garfield.jpg",
      plot: "As if it was not enough that it was a cat, it was a ginger cat",
      rating: 0.2
    }
  end

  before do
    allow(MovieApiService).to receive(:new).and_return(adapter)
    allow(adapter).to receive(:adapt).and_return(adapted)
  end

  describe "#poster" do
    subject { movie.poster }

    it { is_expected.to eq(adapted[:poster]) }
  end

  describe "#plot" do
    subject { movie.plot }

    it { is_expected.to eq(adapted[:plot]) }
  end

  describe "#rating" do
    subject { movie.rating }

    it { is_expected.to eq(adapted[:rating]) }
  end
end
