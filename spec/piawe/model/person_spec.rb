# frozen_string_literal: true

RSpec.describe Piawe::Model::Person do
  let(:instance) do
    build :alice
  end

  describe "#week" do
    subject { instance.week current_date }

    context "on the injury date" do
      let(:current_date) { Date.parse "2017-01-01" }
      it { should eq 1 }
    end

    context "on the next day" do
      let(:current_date) { Date.parse "2017-01-02" }
      it { should eq 1 }
    end

    context "when exactly 7 days (incl day of injury) passed" do
      let(:current_date) { Date.parse "2017-01-07" }
      it { should eq 1 }
    end

    context "when 8 days passed" do
      let(:current_date) { Date.parse "2017-01-08" }
      it { should eq 2 }
    end
  end
end
