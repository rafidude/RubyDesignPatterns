# External iterator
class ArrayIterator
  def initialize(array)
    @array = array
    @index = 0
  end
  def has_next?
    @index < @array.length
  end
  def item
    @array[@index]
  end
  def next_item
    value = @array[@index]
    @index += 1
    value
  end
end

puts "Using External Iterator: "
array = ['red', 'green', 'blue']
i = ArrayIterator.new(array)
while i.has_next?
  puts("item: #{i.next_item}")
end

#internal iterator
def for_each_element(array)
  i = 0
  while i < array.length
    yield(array[i])
    i += 1
  end
end

puts "Using Internal Iterator"
for_each_element(array) {|element| puts "ITEM: #{element}"}

#Built in Enumerable sample
a = ["joe", "sam", "george"]
puts a.all? {|element| element.length < 4}
puts a.any? {|element| element.length < 4}
#Custom Enumerable sample
class Account
  attr_accessor :name, :balance
  def initialize(name, balance)
    @name = name
    @balance = balance
  end
  def <=>(other)
    balance <=> other.balance
  end
end
class Portfolio
  include Enumerable
  def initialize
    @accounts = []
  end
  def add_account(account)
    @accounts << account
  end
  def each(&block)
    @accounts.each(&block)
  end
end
puts "Custom Enumerable Sample"
joe = Account.new("joe", 100)
sam = Account.new("sam", 10)
george = Account.new("george", 3000)
p = Portfolio.new
p.add_account(joe); p.add_account(sam); p.add_account(george)
puts p.any?{|account| account.balance > 2000}
puts p.all?{|account| account.balance >= 10}

#Objectspace sample
#ObjectSpace.each_object(Numeric) {|object| puts "Object: #{object}"}
def subclasses_of(superclass)
  subclasses = []
  ObjectSpace.each_object(Class) do |k|
    next if !k.ancestors.include?(superclass) || superclass == k ||
            k.to_s.include?('::') || subclasses.include?(k.to_s)
    subclasses << k.to_s
  end
  subclasses
end
puts "Objectspace subclasses sample"
puts subclasses_of(Numeric)