# frozen_string_literal: true

RSpec.describe Piawe::Model::Ruleset do
  let(:rules) { [build(:simple_rule)] }
  let(:instance) { described_class.new rules }
  let(:person) { build :alice }

  describe "#apply" do
    subject { instance.apply person, current_date: Date.parse("2017-01-02") }

    it "applies the rule matching current date to the person" do
      expect(subject).to eq 6
    end
  end

  describe "#validate!" do
    subject { instance.validate! }

    context "when there's no overlapping rules" do
      it "does not raise any errors" do
        expect { subject }.to_not raise_error
      end
    end

    context "when two rules overlap" do
      let(:rules) do
        [
          build(:simple_rule),
          build(:simple_rule)
        ]
      end

      it "raises WeekRangeError" do
        expect { subject }.to raise_error Piawe::Model::Ruleset::WeekRangeError
      end
    end
  end
end
