require_relative 'restaurant'
require_relative 'format/number_format'

# Driver class for Restaurant Finder
class Driver
  include NumberFormat
  # Label class for producing actions
  class Label
      @@labels = %w(Add List Find Quit)
      def self.options
        @@labels
      end
  end

  def initialize(file = nil)
    Restaurant.file = file
    if Restaurant.file_usable?
      puts '<< Restaurant File found! >>'.mid
    elsif Restaurant.file_created?
      puts '<< Restaurant File created! >>'.mid
    else
      puts '<< Restaurant File Error! >>'.mid
    end
  end

  def launch!
    intro
    action = ''
    until action == 'quit'
      action, args = do_action
      send(action, args.first)
    end
  end

  def intro
    puts 'Welcome!'.header
    puts
  end

  def quit(_args = {})
    puts
    puts 'Bye!'.header
    exit
  end

  def do_action
    input = ''
    until Driver::Label.options.map(&:downcase).include?(input)
      puts
      puts 'Restaurants > ' + Driver::Label.options.join(', ')
      print '> '
      args = gets.chomp.downcase.strip.split(' ')
      input = args.shift
      args.delete_at(0) if args[0] == 'by' || args[0] == 'using'
    end
    return input, args
  end

  def add(_arg = nil)
    puts 'Adding a restaurant!'.header
    restaurant = Restaurant.build
    if restaurant.save?
      puts 'Restaurant added!'.mid
    else
      puts 'Restaurant not added!'.mid
    end
  end

  def list(sort_order)
    puts 'Listing restaurants!'.header
    restaurant = Restaurant.all_restaurant
    restaurant = sort_restaurant(restaurant, sort_order)
    display(restaurant)
  end

  def find(keyword)
    puts 'Finding restaurants!'.header
    if keyword.empty?
      puts 'No such restaurant found!'.mid
      quit
    end
    restaurant = Restaurant.all_restaurant
    found_restaurants = []
    restaurant.each do |f|
      found_restaurants << f if f.name.downcase.include?(keyword.downcase) ||
                                f.cuisine.downcase.include?(keyword.downcase) ||
                                f.price.to_i <= keyword.to_i
    end
    sort_restaurant(found_restaurants)
    display(found_restaurants)
    puts 'No such restaurant found!'.mid if found_restaurants.empty?
  end

  def display(restaurant)
    puts
    printf "\t%-15s\t\t%-15s\t\t%-15s\n", 'NAME', 'CUISINE', 'PRICE'
    puts
    restaurant.each do |r|
      printf "\t%-15s\t\t%-15s\t\t%-15s\n", r.name.wordcase,
            r.cuisine.wordcase, number_to_currency(r.price)
    end
  end

  def sort_restaurant(restaurant, sort_order = nil)
    sort_order = 'name' unless Restaurant::Label.options.include?(sort_order)
    case sort_order
    when 'name'
      restaurant.sort! { |r1, r2| r1.name.downcase <=> r2.name.downcase }
    when 'cuisine'
      restaurant.sort! { |r1, r2| r1.cuisine.downcase <=> r2.cuisine.downcase }
    when 'price'
      restaurant.sort! { |r1, r2| r1.price.to_i <=> r2.price.to_i }
    end
    restaurant
  end
end
