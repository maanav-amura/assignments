require_relative 'lib/driver'

driver = Driver.new('restaurant_finder/restaurants.txt')
driver.launch!
