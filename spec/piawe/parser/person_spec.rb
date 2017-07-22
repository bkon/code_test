# frozen_string_literal: true

RSpec.describe Piawe::Parser::Person do
  let(:instance) { described_class.new }

  describe "#parse" do
    let(:data) do
      {
        "name" => "Ebony Boycott",
        "hourlyRate" => 75.0030,
        "overtimeRate" => 150.0000,
        "normalHours" => 35.0,
        "overtimeHours" => 7.3,
        "injuryDate" => "2016/05/01"
      }
    end

    subject { instance.parse data }

    it "returns an instance of Model::Person class" do
      expect(subject).to be_an_instance_of(Piawe::Model::Person)
    end

    it "parses the date" do
      expect(subject.injury_date).to eq Date.parse "2016-05-01"
    end

    it "keeps the name" do
      expect(subject.name).to eq "Ebony Boycott"
    end

    it "keeps the hourly rate value" do
      expect(subject.hourly_rate).to eq 75.0030
    end

    it "keeps the overtime rate value" do
      expect(subject.overtime_rate).to eq 150.0000
    end

    it "keeps normal hours" do
      expect(subject.normal_hours).to eq 35.0
    end

    it "keeps overtime hours" do
      expect(subject.overtime_hours).to eq 7.3
    end

    context "when date format is not valid" do
      let(:data) do
        {
          "name" => "Ebony Boycott",
          "hourlyRate" => 75.0030,
          "overtimeRate" => 150.0000,
          "normalHours" => 35.0,
          "overtimeHours" => 7.3,
          "injuryDate" => "FDSJKL"
        }
      end

      it "raises an exception" do
        expect { subject }.to raise_error ArgumentError
      end
    end
  end
end
