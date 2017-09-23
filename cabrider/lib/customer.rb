require_relative 'person'
require_relative 'error'

# Customer details class inherited from Person
class Customer < Person
  include Error

  attr_accessor :distance

  def initialize(name, age)
    super(name, age)
  end

  def print
    puts "\n" + header('customer details :: ')
    puts " Name    => #{name}".upcase
    puts " Age     => #{age}".upcase
  end
end
