require_relative 'person'

# Driver details class inherited from Person class
class Driver < Person
  attr_accessor :rating

  def initialize(name, age)
    super
    @rating = 0.0
  end

  def print
    puts "\n" + header('Taxi driver details :: ')
    puts " Name    => #{name}".upcase
    puts " Age     => #{age}".upcase
    puts " Rating  => #{total_rides.zero? ? 0 : rating / total_rides}".upcase
  end

  def calc_rating(rating)
    @rating += rating
  end
end
