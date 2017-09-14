require 'csv'

#
# Class Course provides courses information and functions
#
# @author Maanav Shah <maanav@amuratech.com>
#
class Course
  @@count = 0
  attr_accessor :name, :college_id

  def initialize(name, college_id)
    @name = name
    @college_id = college_id
  end

  def self.count
    @@count = CSV.open('course.csv', 'r').readlines.size
  end

  #
  # returns an array of the course
  #
  #
  # @return an array of instance variables
  #
  def to_array
    [@name, @college_id]
  end

  def print
    puts "Course Name ::\t#{@name}"
  end

  def self.register(name, college_id)
    course = Course.new(name, college_id)
    course_record = course.to_array
    CSV.open('course.csv', 'a') { |csv| csv << course_record }
  end

  def self.all
    print "\nCourse Details ::\n\n"
    puts "CourseID\tName"
    CSV.foreach('course.csv', 'r').with_index(1) do |record, ln|
      puts "#{ln}\t\t#{record[0].upcase}"
    end
    puts
  end

  #
  # finds the course enrolled
  #
  # @param integer id acts as reference to integer
  #
  # @return course details
  #
  def self.find(id)
    print "\nCourse Details ::\n\n"
    CSV.foreach('course.csv', 'r').with_index(1) do |record, ln|
      Course.new(record[0].upcase, record[1]).print if ln == id
    end
  end

  #
  # finds the college which course belongs
  #
  # @param [int] course_id acts as a reference key of college
  #
  # @return the details of college
  #
  def self.find_course_college(course_id)
    print "\nCourse is included in College ::\n"
    CSV.foreach('course.csv', 'r').with_index(1) do |record, ln|
      College.find(record[1].to_i) if ln == course_id
    end
  end
end
