class Journey
  attr_reader :entry_station, :exit_station

  MIN_FARE = 2
  PENALTY_FARE = 6

  def start_journey(station)
  	@entry_station = station
  end

  def end_journey(station)
    @exit_station = station
  end

  def fare
    @entry_station && @exit_station ? MIN_FARE : PENALTY_FARE
  end

  def journey_complete?
    @entry_station && @exit_station ? true : false
  end
end
