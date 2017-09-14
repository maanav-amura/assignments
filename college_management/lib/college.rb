require 'csv'
require_relative 'course'

class College
  attr_accessor :name, :city

  def self.register(name, city)
    college_record = [name, city]
    CSV.open('college.csv', 'a') { |csv| csv << college_record }
  end

  def self.all
    print "\nCollege Details ::\n\n"
    puts "CollegeID\tName"
    CSV.foreach('college.csv', 'r').with_index(1) { |record, ln| puts "#{ln}\t\t#{record[0].capitalize}" }
    puts
  end

  def self.find(id)
    print "\nCollege Details ::\n\n"
    puts "Name\tCity"
    CSV.foreach('college.csv', 'r').with_index(1) { |record, ln| puts "#{record[0].capitalize}\t#{record[1].capitalize}" if ln == id }
  end
end
