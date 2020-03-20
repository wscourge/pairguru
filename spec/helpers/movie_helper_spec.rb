# frozen_string_litreal: true

class Dummy
  include MovieHelper
end

describe MovieHelper do
  let(:dummy) { Dummy.new }

  describe "#rating_class" do
    context "with rating below 1" do
      it { expect(dummy.rating_class(-5)).to eq("text-muted") }
      it { expect(dummy.rating_class(0)).to eq("text-muted") }
      it { expect(dummy.rating_class(0.5)).to eq("text-muted") }
      it { expect(dummy.rating_class(0.9999)).to eq("text-muted") }
    end

    context "with rating between 1 and 4" do
      it { expect(dummy.rating_class(1)).to eq("text-danger") }
      it { expect(dummy.rating_class(2.5)).to eq("text-danger") }
      it { expect(dummy.rating_class(3.99)).to eq("text-danger") }
    end

    context "with rating between 4 and 6" do
      it { expect(dummy.rating_class(4)).to eq("text-warning") }
      it { expect(dummy.rating_class(5.5)).to eq("text-warning") }
      it { expect(dummy.rating_class(6)).to eq("text-warning") }
    end

    context "with rating between 6 and 8" do
      it { expect(dummy.rating_class(6.01)).to eq("text-info") }
      it { expect(dummy.rating_class(7.5)).to eq("text-info") }
      it { expect(dummy.rating_class(7.99)).to eq("text-info") }
    end

    context "with rating between 8 and 10" do
      it { expect(dummy.rating_class(8)).to eq("text-success") }
      it { expect(dummy.rating_class(9.5)).to eq("text-success") }
      it { expect(dummy.rating_class(10.0)).to eq("text-success") }
    end
  end
end
