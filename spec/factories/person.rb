# frozen_string_literal: true

FactoryGirl.define do
  factory :person, class: Piawe::Model::Person do
    factory :alice do
      initialize_with do
        new name: "Alice Atkinson",
            hourly_rate: 10,
            overtime_rate: 25,
            normal_hours: 1,
            overtime_hours: 2,
            injury_date: Date.parse("2017-01-01")
      end
    end
  end
end
