module Subject
  def initialize
    @observers = []
  end
  def add_observer(&observer)
    @observers << observer
  end
  def delete_observer(observer)
    @observers.delete(observer)
  end
  def notify_observers
    @observers.each do |observer|
      observer.call(self)
    end
  end
end
class Employee
  include Subject
  attr_accessor :name, :title, :salary
  def initialize(name, title, salary)
    super()
    @name = name; @title = title; @salary=salary
  end
  def salary=(new_salary)
    @salary = new_salary
    notify_observers
  end
end

emp = Employee.new("Fred", "Janitor", 30000)
emp.add_observer do |subject|
  puts "In HR: " + subject.name + "'s new salary: " + subject.salary.to_s  
end
emp.salary=100000
