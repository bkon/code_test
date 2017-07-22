# frozen_string_literal: true

require "json"

class Piawe::Reader::People
  def read(file)
    people_data = JSON.parse File.read file
    people_data["people"].map do |obj|
      Piawe::Parser::Person.new.parse obj
    end
  end
end
