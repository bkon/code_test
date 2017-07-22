# frozen_string_literal: true

class Piawe::Struct < Struct
  def initialize(**kwargs)
    super(*members.map { |k| kwargs.fetch(k) })
  end
end
