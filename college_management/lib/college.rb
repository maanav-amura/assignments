require 'csv'

#
# Class College provides college information and functions
#
# @author Maanav Shah <maanav@amuratech.com>
#
class College
  @@count = 0
  attr_accessor :name, :city

  def initialize(name, city)
    @name = name
    @city = city
  end

  def self.count
    @@count = CSV.open('college.csv', 'r').readlines.size
  end

  #
  # returns an array of the college
  #
  #
  # @return an array of instance variables
  #
  def to_array
    [@name, @city]
  end

  def print
    puts "Name ::\t#{@name}"
    puts "City ::\t#{@city}"
  end

  def self.register(name, city)
    college = College.new(name, city)
    college_record = college.to_array
    CSV.open('college.csv', 'a') { |csv| csv << college_record }
  end

  #
  # displays list of colleges
  #
  #
  # @return list of colleges are displayed
  #
  def self.all
    print "\nCollege Details ::\n\n"
    puts "CollegeID\tName\tCity"
    CSV.foreach('college.csv', 'r').with_index(1) do |record, ln|
      puts "#{ln}\t\t#{record[0].capitalize}\t#{record[1].capitalize}"
    end
    puts
  end

  #
  # searches the courses which college provides
  #
  # @param [integer] college_id acts as a refernce key for finding course
  #
  # @return list of courses available in that college
  #
  def self.find_college_courses(college_id)
    print "\nCourses Available ::\n\n"
    CSV.foreach('course.csv', 'r') do |record|
      puts "#{record[0].upcase}" if record[1].to_i == college_id
    end
  end

  #
  # displays the college detail
  #
  # @param [<type>] id <description>
  #
  # @return [<type>] <description>
  #
  def self.find(id)
    print "\nCollege Details ::\n\n"
    CSV.foreach('college.csv', 'r').with_index(1) do |record, ln|
      College.new(record[0].capitalize, record[1].capitalize).print if ln == id
    end
  end
end
