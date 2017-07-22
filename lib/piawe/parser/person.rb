# frozen_string_literal: true

require "date"

class Piawe::Parser::Person
  def parse(json_object)
    Piawe::Model::Person
      .new name: json_object["name"],
           hourly_rate: json_object["hourlyRate"],
           overtime_rate: json_object["overtimeRate"],
           normal_hours: json_object["normalHours"],
           overtime_hours: json_object["overtimeHours"],
           injury_date: ::Date.strptime(json_object["injuryDate"], "%Y/%m/%d")
  end
end
