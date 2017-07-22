# frozen_string_literal: true

class Piawe::Model::Ruleset
  class WeekRangeError < StandardError; end

  def initialize(rules)
    @rules = rules
  end

  def apply(person, current_date:)
    applicable_rule(person.week(current_date))
      .apply(person)
  end

  def validate!
    @rules.each_with_index do |a, index|
      @rules[(index + 1)..@rules.length].each do |b|
        if a.intersects?(b)
          raise WeekRangeError,
                "Week ranges #{a.weeks} and #{b.weeks} intersect"
        end
      end
    end
  end

  private

  def applicable_rule(week)
    @rules.detect { |r| r.applies? week } || Piawe::Model::Rule.null
  end
end
