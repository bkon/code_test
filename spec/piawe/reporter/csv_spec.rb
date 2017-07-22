# frozen_string_literal: true

RSpec.describe Piawe::Reporter::Csv do
  let(:ruleset) do
    build :simple_ruleset
  end

  let(:person) do
    build :alice
  end

  let(:instance) do
    described_class.new current_date: Date.parse("2017-01-02"),
                        ruleset: ruleset
  end

  describe "#generate" do
    subject { instance.generate [person] }

    it "returns a CSV string" do
      expect(subject).to eq <<~EOF
      Name,Week,Payout
      Alice Atkinson,1,6.0
EOF
    end
  end
end
