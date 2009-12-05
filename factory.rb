class Duck
  def initialize(name)
    @name = name
  end
  def eat
    puts("Duck #{@name} is eating")
  end
  def speak
    puts("Duck #{@name} says Quack")
  end
  def sleep
    puts("duck #{@name} sleeps quietly")
  end
end
class Frog
  def initialize(name)
    @name = name
  end
  def eat
    puts("Frog #{@name} is eating")
  end
  def speak
    puts("Frog #{@name} says Crooooaaak")
  end
  def sleep
    puts("Frog #{@name} doesn't sleep; he croaks all night")
  end
end
class Algae
  def initialize(name)
    @name = name
  end
  def grow
    puts("The Algae #{@name} soaks up the sun and grows")
  end
end
class WaterLily
  def initialize(name)
    @name = name
  end
  def grow
    puts("The water Lily #{@name} floats, soaks up the sun and grows")
  end
end
class Pond
  def initialize(number_animals)
    @animals = []
    number_animals.times do |i|
      animal = new_animal("Animal#{i}")
      @animals << animal
    end
  end
  def simulate_one_day
    @animals.each {|animal| animal.speak}
    @animals.each {|animal| animal.eat}
    @animals.each {|animal| animal.sleep}
  end
end
class DuckPond < Pond
  def new_animal(name)
    Duck.new(name)
  end
end
class FrogPond < Pond
  def new_animal(name)
    Frog.new(name)
  end
end
pond = DuckPond.new(3)
pond.simulate_one_day

class Pond2
  def initialize(number_animals, animal_class,
          number_plants, plant_class)
    @animal_class = animal_class
    @plant_class = plant_class
    @animals = []
    number_animals.times do |i|
      animal = new_organism(:animal, "Animal#{i}")
      @animals << animal
    end
    @plants = []
    number_plants.times do |i|
      plant = new_organism(:plant, "Plant#{i}")
      @plants << plant
    end
  end
  def simulate_one_day
    @plants.each {|plant| plant.grow}
    @animals.each {|animal| animal.speak}
    @animals.each {|animal| animal.eat}
    @animals.each {|animal| animal.sleep}
  end
  def new_organism(type, name)
    if type == :animal
      @animal_class.new(name)
    elsif type == :plant
      @plant_class.new(name)
    else
      raise "Unknown organism type: #{type}"
    end
  end
end
pond2 = Pond2.new(3, Duck, 2, WaterLily)
pond2.simulate_one_day
class Tree
  def initialize(name)
    @name = name
  end
  def grow
    puts("The tree #{@name} grows tall")
  end
end
class Tiger
  def initialize(name)
    @name = name
  end
  def eat
    puts("Tiger #{@name} eats anything it wants.")
  end
  def speak
    puts("Tiger #{@name} Roars!")
  end
  def sleep
    puts("Tiger #{@name} sleeps anywhere it wants")
  end
end
class OrganismFactory
  def initialize(plant_class, animal_class)
    @plant_class = plant_class
    @animal_class = animal_class
  end
  def new_animal(name)
    @animal_class.new(name)
  end
  def new_plant(name)
    @plant_class.new(name)
  end
end
class Habitat
  def initialize(number_animals, number_plants, organism_factory)
    @organism_factory = organism_factory
    @animals = []
    number_animals.times do |i|
      animal = @organism_factory.new_animal("Animal#{i}")
      @animals << animal
    end
    @plants = []
    number_plants.times do |i|
      plant = @organism_factory.new_plant("Plant#{i}")
      @plants << plant
    end
  end
    def simulate_one_day
    @plants.each {|plant| plant.grow}
    @animals.each {|animal| animal.speak}
    @animals.each {|animal| animal.eat}
    @animals.each {|animal| animal.sleep}
  end
end
jungle_organism_factory = OrganismFactory.new(Tree, Tiger)
pond_organism_factory = OrganismFactory.new(WaterLily, Frog)
jungle = Habitat.new(1,4, jungle_organism_factory)
jungle.simulate_one_day
pond = Habitat.new(2,3, pond_organism_factory)
pond.simulate_one_day

