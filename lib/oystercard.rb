require_relative 'journey'

class Oystercard
  attr_reader :balance, :journeys, :current_journey

  def initialize(balance = 0)
    @balance = balance
    @journeys = []
  end

  def top_up(amount = 0)
    raise "Top-up over max balance £#{MAX_BALANCE}" if exceed_balance?(amount)
    increment_balance(amount)
  end

  def in_journey?
    !!@current_journey && !@current_journey.journey_complete?
  end

  def touch_in(station)
    raise 'Not enough funds' if balance < LOW_BALANCE
    touch_out(nil) if in_journey?
    new_journey
    @current_journey.start_journey(station)
  end

  def touch_out(station)
    touch_in(nil) unless in_journey?
    @current_journey.end_journey(station)
    deduct(@current_journey.fare)
    add_journey
    reset_journey
  end

  private

  MAX_BALANCE = 100
  LOW_BALANCE = 1

  def exceed_balance?(amount)
    @balance + amount > MAX_BALANCE
  end

  def new_journey
    @current_journey = Journey.new
  end

  def reset_journey
    @current_journey = nil
  end

  def increment_balance(amount)
    @balance += amount
  end

  def deduct(fare)
    @balance -= fare
  end

  def add_journey
    @journeys << @current_journey
  end
end
