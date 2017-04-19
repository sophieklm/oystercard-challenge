
class Oystercard

  attr_reader :balance, :in_journey

  def initialize(balance = 0)
    @balance = balance
    @in_journey = false
  end

  def top_up(amount = 0)
    raise "Top-up over max balance £#{MAXBALANCE}" if exceed_balance?(amount)
    increment_balance(amount)
  end

  def deduct(fare)
    self.balance -= fare
  end

  def in_journey?
    in_journey
  end

  def touch_in
    raise 'Not enough funds' if self.balance < 1
    raise 'Already travelling' if in_journey?
    change_journey_status
  end

  def touch_out
    raise 'ERROR! Not travelling!' if in_journey? == false
    change_journey_status
  end

  private

  attr_writer :balance, :in_journey

  MAXBALANCE = 100

  def exceed_balance?(amount)
    self.balance + amount > MAXBALANCE
  end

  def increment_balance(amount)
    self.balance += amount
  end

  def change_journey_status
    return self.in_journey = false if in_journey?
    return self.in_journey = true if in_journey? == false
  end
end
