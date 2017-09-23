require_relative 'taxi'
require_relative 'driver'
require_relative 'customer'
require_relative 'format'
require_relative 'error'

# Taxi System driver class
class TaxiSystem
  include Format
  include Error

  REGEX = /^[1-9][0-9]$/

  attr_accessor :customer, :driver, :taxi
  attr_reader :options, :booking

  def launch!
    @options = %w[book view quit]
    @booking = %w[start cancel]
    intro
    @driver = Driver.new('David', 30)
    driver.print
    @taxi = Taxi.new('MH_1234', driver, 40, true)
    taxi.print
    @customer = define_customer
    customer.print
    process
  end

  def intro
    puts "\n" + header('welcome to Cab Rider!')
  end

  def define_customer
    puts "\n ENTER CUSTOMER DETAILS :: "
    name = define_customer_name
    age = define_customer_age
    Customer.new(name, age)
  end

  def define_customer_name(name = '')
    print ' Enter Name => '
    name = gets.chomp
    until name.split(' ').map { |n| n.match?(/^[a-zA-Z]+$/) }.reduce(:&)
      puts ' NameError :: Please enter valid name!'
      print ' Enter Name => '
      name = gets.chomp
    end
    name
  end

  def define_customer_age(age = '')
    until age.match?(REGEX)
      begin
        print ' Enter Age  => '
        age = gets.chomp
        raise AgeError unless age.match?(REGEX)
      rescue AgeError => exception
        exception.message
      else
        return age
      end
    end
  end

  def process
    input = ''
    until options.include?(input)
      puts "\n" + header('=== Cab Rider ===')
      puts ' => BOOK TAXI'
      puts ' => VIEW BOOKINGS OF TAXI'
      puts ' => QUIT'
      print ' >  '
      input = gets.chomp.downcase
    end
    send(input)
  end

  def define_customer_distance(distance = '')
    until distance.match?(REGEX)
      begin
        print ' Enter Distance to Travel :: '
        distance = gets.chomp
        raise DistanceError unless distance.match?(REGEX)
      rescue DistanceError => exception
        exception.message
      else
        return distance.to_i
      end
    end
  end

  def book
    @customer.distance = define_customer_distance
    puts " FARE => #{taxi.calc_fare(customer.distance)}"
    puts ' TAXI IS BOOKED!'
    @taxi.available = false
    taxi.print
    go_ride
  end

  def go_ride
    input = ''
    until booking.include?(input)
      puts "\n" + header('ENTER RIDE OPTION :: ')
      puts ' => START RIDE'
      puts ' => CANCEL RIDE'
      print ' >  '
      input = gets.chomp.downcase
    end
    send(input)
  end

  def start
    puts ' starting ride!'.upcase
    ride_now
    ride_insert
    puts ' ride ended!'.upcase
    @driver.calc_rating(find_rating)
    driver.print
    @taxi.available = true
    taxi.print
    process
  end

  def ride_now(str = ' .')
    1.upto(3) do
      puts str
      sleep(1)
    end
    @customer.total_rides += 1
    @driver.total_rides += 1
  end

  def ride_insert
    File.open('rides','a') { |f| f.puts "#{taxi.taxi_no}\t#{customer.name}\t#{driver.name}\t#{customer.distance}\t#{taxi.calc_fare(customer.distance)}" }
  end

  def find_rating(rating = '')
    until rating.match?(/^[1-5]$/)
      begin
        print ' Enter Driver rating :: '
        rating = gets.chomp
        raise RatingError unless rating.match?(/^[1-5]$/)
      rescue RatingError => exception
        exception.message
      end
    end
    rating.to_f
  end

  def cancel
    @taxi.available = true
    taxi.print
    @customer.distance = 0
    puts header('taxi cancel and now available!')
    process
  end

  def quit
    puts header('bye!')
    exit
  end



  def view
    begin
      raise FileNotFoundError unless File.exists?('rides')
      f = File.open('rides','r')
    rescue FileNotFoundError => e
      e.message
    end
    puts "\n" + header('=== logs ===')
    print "\n\tTaxi\tCustomer\tDriver\tFare\n\n"
    f.each_line do |line|
      taxi_no, cust_name, driver_name, distance, fare = line.split("\t")
      puts "\t#{taxi_no}\t#{cust_name}\t\t#{driver_name}\t#{fare}"
    end
    f.close
    process
  end
end
