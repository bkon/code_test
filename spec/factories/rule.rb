# frozen_string_literal: true

FactoryGirl.define do
  factory :rule, class: Piawe::Model::Rule do
    factory :simple_rule do
      initialize_with do
        new weeks: 1..10,
            percentage_payable: 0.1,
            overtime_included: true
      end
    end
  end
end
