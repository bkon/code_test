# frozen_string_literal: true

Piawe::Model::Person = Piawe::Struct.new :name,
                                         :hourly_rate,
                                         :overtime_rate,
                                         :normal_hours,
                                         :overtime_hours,
                                         :injury_date do
  def week(current_date)
    injury_date.step(current_date, 7).count
  end
end
