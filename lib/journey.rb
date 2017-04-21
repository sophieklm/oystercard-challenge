
class Journey

  attr_reader :entry_station, :exit_station

  def start_journey(station)
  	@entry_station = station
  end

  def end_journey(station)
  	@exit_station = station
  end

  def fare
  	MIN_FARE
  end

  private

  MIN_FARE = 2

end
