# frozen_string_literal: true

require "json"

class Piawe::Reader::Ruleset
  def read(file)
    rules_data = JSON.parse File.read file
    rules = rules_data["rules"].map { |obj| Piawe::Parser::Rule.new.parse obj }

    ruleset = Piawe::Model::Ruleset.new rules
    ruleset.validate!
    ruleset
  end
end
