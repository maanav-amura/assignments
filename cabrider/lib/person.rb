require_relative 'format'

# Person details class, superclass of Customer, Driver
class Person
  include Format
  attr_accessor :name, :age, :total_rides

  def initialize(name, age, total_rides = 0)
    @name = name
    @age = age
    @total_rides = total_rides
  end
end
