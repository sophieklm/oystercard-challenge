class Oystercard
  attr_accessor :balance

  def initialize (balance = 0)
    @balance = balance
  end

  def top_up(amount = 0)
    raise 'Top-up is over maximum balance' if (self.balance + amount > 90)
    self.balance += amount 
  end
end

