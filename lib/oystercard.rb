
class Oystercard
  attr_reader :balance

  def initialize(balance = 0)
    @balance = balance
  end

  def top_up(amount = 0)
    raise "Top-up over max balance £#{MAXBALANCE}" if exceed_balance?(amount)
    increment_balance(amount)
  end

  def deduct(fare)
    self.balance -= fare
  end

  def in_journey?
    false
  end

  def touch_in
  end
  
  private

  attr_writer :balance

  MAXBALANCE = 100

  def exceed_balance?(amount)
    self.balance + amount > MAXBALANCE
  end

  def increment_balance(amount)
    self.balance += amount
  end

end
