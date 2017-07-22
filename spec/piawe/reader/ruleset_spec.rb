# frozen_string_literal: true

RSpec.describe Piawe::Reader::Ruleset do
  let(:instance) { described_class.new }

  describe "#read" do
    subject { instance.read "test.json" }

    let(:rules_text) do
      {
        "rules" => [
          {
            "applicableWeeks" => "1-26",
            "percentagePayable" => 90,
            "overtimeIncluded" => true
          }
        ]
      }.to_json
    end

    before do
      allow(File).to receive(:read).and_return rules_text
    end

    it "attempts to read the selected file" do
      expect(File).to receive(:read).with "test.json"
      subject
    end

    it "validates the rule set it read from the file" do
      expect_any_instance_of(Piawe::Model::Ruleset).to receive :validate!
      subject
    end

    it "returns the Ruleset object" do
      expect(subject).to be_instance_of Piawe::Model::Ruleset
    end
  end
end
