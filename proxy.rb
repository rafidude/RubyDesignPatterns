class BankAccount
  attr_reader :balance
  def initialize(starting_balance = 0)
    @balance = starting_balance
  end
  def deposit(amount)
    @balance += amount
  end
  def withdraw(amount)
    @balance -= amount
  end
end
class VirtualAccountProxy
  def initialize(starting_balance=0)
    @starting_balance = starting_balance
  end
  def subject
    @subject || (@subject = BankAccount.new(100))
  end
  def deposit(amount)
    s = subject
    s.deposit(amount)
  end
  def withdraw(amount)
    s = subject
    s.withdraw(amount)
  end
  def balance
    s = subject
    s.balance
  end
end
puts "Hard coded BankAccount into VirtualAccountProxy"
v = VirtualAccountProxy.new {BankAccount.new(100)}
puts v.balance

#Eliminating that proxy drudgery or code duplication, using method_missing
class VitualProxy
  def initialize(&creation_block)
    @creation_block = creation_block
  end
  def method_missing(name, *args)
    s = subject
    s.send(name, *args)
  end
  def subject
    @subject || (@subject = @creation_block.call)
  end
end
puts "Using method_missing and object creation block"
v1 = VitualProxy.new {BankAccount.new(9000)}
puts v1.balance
puts v1.deposit(21000)