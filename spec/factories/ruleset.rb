# frozen_string_literal: true

FactoryGirl.define do
  factory :ruleset, class: Piawe::Model::Ruleset do
    factory :simple_ruleset do
      initialize_with do
        new [build(:simple_rule)]
      end
    end
  end
end
