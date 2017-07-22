# frozen_string_literal: true

class Piawe::Parser::Rule
  NUMBER_OF_WEEKS_IN_100_YEARS = 5214

  def parse(json_object)
    Piawe::Model::Rule
      .new weeks: weeks(json_object["applicableWeeks"]),
           percentage_payable: json_object["percentagePayable"] / 100.0,
           overtime_included: json_object["overtimeIncluded"]
  end

  def weeks(week_string)
    case week_string
    when /^(\d+)-(\d+)$/
      (Regexp.last_match[1].to_i..Regexp.last_match[2].to_i)
    when /^(\d+)\+$/
      # Note: please update this value if we're geting too many
      # complaints from injured ancients
      (Regexp.last_match[1].to_i..NUMBER_OF_WEEKS_IN_100_YEARS)
    when /^(\d+)$/
      from = Regexp.last_match[1].to_i
      (from..from)
    else
      raise ArgumentError, error_msg(week_string)
    end
  end

  private

  def error_msg(week_string)
    <<~EOF
      Week string '#{week_string}' should have one of the following formats:
      '<week>', '<from>+', '<from>-<to>'
    EOF
  end
end
