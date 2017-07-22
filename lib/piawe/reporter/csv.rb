# frozen_string_literal: true

require "csv"

class Piawe::Reporter::Csv
  attr_reader :current_date, :ruleset

  def initialize(current_date:, ruleset:)
    @current_date = current_date
    @ruleset = ruleset
  end

  def generate(people)
    CSV.generate do |csv|
      csv << %w[Name Week Payout]
      people.each do |person|
        csv << [
          person.name,
          person.week(current_date),
          ruleset.apply(person, current_date: current_date)
        ]
      end
    end
  end
end
