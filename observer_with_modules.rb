require 'observer'
class Employee
  include Observable
  attr_reader :name, :title, :salary
  def initialize(name, title, salary)
    @name = name; @title = title; @salary=salary
  end
  def salary=(new_salary)
    @salary = new_salary
    changed
    notify_observers(self)
  end
end
class HR
  def update(subject)
    puts "In HR: " + subject.name + "'s new salary: " + subject.salary.to_s
  end
end

emp = Employee.new("Fred", "Janitor", 30000)
hr = HR.new
emp.add_observer(hr)
emp.salary=100000
