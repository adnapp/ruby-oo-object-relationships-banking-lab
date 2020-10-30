class Transfer

  attr_accessor :sender, :receiver, :amount, :status

  def initialize(sender, receiver, amount)
    @sender = sender
    @receiver = receiver
    @amount = amount
    @status = "pending"
  end

  def valid?
    self.receiver.valid? && self.sender.valid? 
  end    

  def execute_transaction
    if self.valid? && self.status == "pending" && self.sender.balance > self.amount
        self.sender.withdraw(self.amount)
        self.receiver.deposit(self.amount)
        self.status = "complete"
    else
      self.status = "rejected"
      "Transaction rejected. Please check your account balance."
    end
  end

  def reverse_transfer
    if self.valid? && self.status == "complete" 
      self.receiver.withdraw(self.amount)
      self.sender.deposit(self.amount)
      self.status = "reversed"
    end
  end

end
