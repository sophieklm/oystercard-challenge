class Oystercard
  attr_reader :balance

  def initialize (balance = 0)
    @balance = balance
  end

  def top_up(amount = 0)
    raise "Top-up is over maximum balance #{MAXBALANCE}" if exceed_balance?(amount)
    increment_balance(amount)
  end

  private
  attr_writer :balance

  MAXBALANCE = 100

  def exceed_balance?(amount)
    (self.balance + amount > MAXBALANCE)
  end

  def increment_balance(amount)
    self.balance += amount
  end

end
