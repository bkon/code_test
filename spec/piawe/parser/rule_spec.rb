# frozen_string_literal: true

RSpec.describe Piawe::Parser::Rule do
  let(:instance) { described_class.new }

  describe "#weeks" do
    subject { instance.weeks weeks }

    context "when input is in 10-20 format" do
      let(:weeks) { "10-20" }

      it "returns a range 10..20" do
        expect(subject).to eq 10..20
      end
    end

    context "when input is in 10+ format" do
      let(:weeks) { "10+" }

      it "returns a range with upper bound set to 100 years in weeks" do
        expect(subject).to eq 10..5214
      end
    end

    context "when input is in '10' format" do
      let(:weeks) { "10" }

      it "returns a range with a single element" do
        expect(subject).to eq 10..10
      end
    end

    context "when input format is not recognizable" do
      let(:weeks) { "$#&*(&())" }

      it "raises an exception" do
        expect { subject }.to raise_error ArgumentError
      end
    end
  end

  describe "#parse" do
    let(:data) do
      {
        "applicableWeeks" => "1-26",
        "percentagePayable" => 90,
        "overtimeIncluded" => true
      }
    end

    subject { instance.parse data }

    it "returns an instance of the Model::Rule class" do
      expect(subject).to be_an_instance_of(Piawe::Model::Rule)
    end

    it "transforms weeks string to the integer range" do
      expect(subject.weeks).to eq 1..26
    end

    it "converts percentage value to 0..1 range multiplier" do
      expect(subject.percentage_payable).to eq 0.9
    end

    it "keeps overtime included flag as-is" do
      expect(subject.overtime_included).to eq true
    end
  end
end
