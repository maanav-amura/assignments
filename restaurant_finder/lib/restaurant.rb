require_relative './format/string_format'

# Restaurant class
class Restaurant
  # Label class for producing options
  class Label
    def self.options
      @@options = ['name', 'cuisine', 'price']
    end
  end

  @@file = nil
  attr_accessor :name, :cuisine, :price

  def initialize(args = {})
    @name = args[:name] || ''
    @cuisine = args[:cuisine] || ''
    @price = args[:price] || ''
  end

  def self.file=(file = nil)
    @@file = File.join(file)

  end
  def self.file_usable?
    return false unless @@file
    return false unless File.exist?(@@file)
    return false unless File.readable?(@@file)
    return false unless File.writable?(@@file)
    true
  end

  def self.file_created?
    File.new(@@file, 'w')
    file_usable?
  end

  def self.build
    args = {}
    puts 'Restaurant'
    print 'Name    >  '
    args[:name] = gets.chomp.capitalize
    print 'Cuisine >  '
    args[:cuisine] = gets.chomp.capitalize
    print 'Price   >  '
    args[:price] = gets.chomp.to_i
    Restaurant.new(args)
  end

  def self.all_restaurant
    restaurant = []
    File.open(@@file, 'r') do |file|
      file.each_line { |line| restaurant << Restaurant.new.create(line) }
    end
    restaurant
  end

  def save?
    return false unless Restaurant.file_usable?
    File.open(@@file, 'a+') do |f|
      f.puts [@name, @cuisine, @price].join('\t').to_s
    end
    true
  end

  def create(line)
    @name, @cuisine, @price = line.split('\t')
    self
  end
end
