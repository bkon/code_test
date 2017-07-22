# frozen_string_literal: true

RSpec.describe Piawe::Reader::People do
  let(:instance) { described_class.new }

  describe "#read" do
    subject { instance.read "test.json" }

    let(:text) do
      {
        "people" => [
          {
            "name" => "Ebony Boycott",
            "hourlyRate" => 75.0030,
            "overtimeRate" => 150.0000,
            "normalHours" => 35.0,
            "overtimeHours" => 7.3,
            "injuryDate" => "2016/05/01"
          }
        ]
      }.to_json
    end

    before do
      allow(File).to receive(:read).and_return text
    end

    it "attempts to read the selected file" do
      expect(File).to receive(:read).with "test.json"
      subject
    end

    it "returns the array of Person instances" do
      expect(subject).to match [an_instance_of(Piawe::Model::Person)]
    end
  end
end
