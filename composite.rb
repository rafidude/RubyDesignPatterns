class Task
  attr_accessor :name, :parent
  def initialize(name)
    @name = name
    @parent = nil
  end
  def get_duration
    0.0
  end
  def count_basic_tasks
    1
  end
end
class CompositeTask < Task
  def initialize(name)
    super(name)
    @sub_tasks = []
  end
  def add_sub_task(task)
    @sub_tasks << task
    task.parent = self
  end
  def remove_sub_task(task)
    @sub_tasks.delete(task)
    task.parent = nil
  end
  def get_duration
    time = 0.0
    @sub_tasks.each{|task| time += task.get_duration}
    time
  end
  def [](index)
    @sub_tasks[index]
  end
  def []=(index, new_value)
    @sub_tasks[index] = new_value
  end
  def count_basic_tasks
    count = 0
    @sub_tasks.each{|task| count += task.count_basic_tasks}
    count
  end
end
class AddDryIngredientsTask < Task
  def initialize
    super("Add dry ingrdients")
  end
  def get_duration
    1.0             # 1 minute to add flour and sugar
  end
end
class MixTask < Task
  def initialize
    super("Mix that batter up!")
  end
  def get_duration
    3.0             # Mix for 3 minutes
  end
end
class MakeBatterTask < CompositeTask
  def initialize
    super('Make batter')
    add_sub_task(AddDryIngredientsTask.new)
    add_sub_task(MixTask.new)
  end
end

m = MakeBatterTask.new
puts m.get_duration.to_s
puts m.count_basic_tasks.to_s