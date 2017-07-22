# frozen_string_literal: true

RSpec.describe Piawe::Model::Rule do
  let(:overtime_included) { false }
  let(:instance) do
    described_class.new weeks: 5..10,
                        percentage_payable: 0.1,
                        overtime_included: overtime_included
  end

  describe "#applies?" do
    subject { instance.applies? week }

    context "when current week is in range" do
      let(:week) { 6 }
      it { should be_truthy }
    end

    context "when current week is not in range" do
      let(:week) { 11 }
      it { should be_falsy }
    end
  end

  describe "apply" do
    let(:person) { build :alice }
    subject { instance.apply person }

    context "when overtime payment is included" do
      let(:overtime_included) { true }

      it "adds normal and overtime payment" do
        expect(subject).to eq 6
      end
    end

    context "when overtime payment is not included" do
      let(:overtime_included) { false }

      it "adds only normal payment" do
        expect(subject).to eq 1
      end
    end
  end

  describe "#intersects?" do
    subject { instance.intersects? other_rule }

    let(:other_rule) do
      described_class.new weeks: weeks,
                          percentage_payable: 0.1,
                          overtime_included: overtime_included
    end

    context "when rules are exactly separate" do
      let(:weeks) { 20..25 }
      it { should be_falsy }
    end

    context "when other rule starts inside this range" do
      let(:weeks) { 7..20 }
      it { should be_truthy }
    end

    context "when other rule ends inside this range" do
      let(:weeks) { 1..7 }
      it { should be_truthy }
    end

    context "when other rule starts on the same week this rule ends" do
      let(:weeks) { 10..20 }
      it { should be_truthy }
    end

    context "when other rule ends on the same week this rule starts" do
      let(:weeks) { 1..5 }
      it { should be_truthy }
    end

    context "when other rule is fully contained within this rule" do
      let(:weeks) { 6..7 }
      it { should be_truthy }
    end

    context "when this rule is fully contained within other rule" do
      let(:weeks) { 1..20 }
      it { should be_truthy }
    end
  end

  describe ".null" do
    subject { described_class.null }

    it "returns an instance of Rule" do
      expect(subject).to be_instance_of described_class
    end
  end
end
