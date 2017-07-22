# frozen_string_literal: true

class Piawe::Model::Rule
  attr_reader :weeks,
              :percentage_payable,
              :overtime_included
  alias overtime_included? overtime_included

  def initialize(weeks:, percentage_payable:, overtime_included:)
    @weeks = weeks
    @percentage_payable = percentage_payable
    @overtime_included = overtime_included
  end

  def applies?(week)
    weeks.cover? week
  end

  def apply(person)
    (
      (
        apply_normal(person) +
        apply_overtime(person)
      ) * percentage_payable
    ).round 2
  end

  def intersects?(rule)
    contains_boundary_of?(rule) || rule.contains_boundary_of?(self)
  end

  def contains_boundary_of?(rule)
    weeks.cover?(rule.weeks.begin) || weeks.cover?(rule.weeks.end)
  end

  def self.null
    new weeks: (0...0), # Empty range
        percentage_payable: 0,
        overtime_included: false
  end

  private

  def apply_normal(person)
    person.hourly_rate * person.normal_hours
  end

  def apply_overtime(person)
    return 0 unless overtime_included?
    person.overtime_rate * person.overtime_hours
  end
end
