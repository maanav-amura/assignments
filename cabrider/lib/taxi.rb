require_relative 'format'

# Taxi details class
class Taxi
  include Format

  attr_accessor :taxi_no, :driver, :rate, :available

  def initialize(taxi_no, driver, rate, available)
    @taxi_no = taxi_no
    @driver = driver
    @rate = rate
    @available = available
  end

  def print
    puts "\n" + header('taxi details :: ')
    puts " taxi No    => #{taxi_no}".upcase
    puts " rate       => #{rate}".upcase
    puts " available  => #{(available ? 'Yes' : 'No')}".upcase
  end

  def calc_fare(distance)
    distance * rate
  end
end

