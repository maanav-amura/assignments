#
# Class Student provides students information and functions
#
# @author Maanav Shah <maanav@amuratech.com>
#
class Student
  attr_accessor :name, :age, :college_student_id, :course_student_id

  def initialize(name, age, college_student_id, course_student_id)
    @name = name
    @age = age
    @college_student_id = college_student_id
    @course_student_id = course_student_id
  end

  #
  # returns an array of the student
  #
  #
  # @return array
  #
  def to_array
    [@name, @age, @college_student_id, @course_student_id]
  end

  def print
    puts "Name ::\t#{@name}"
    puts "Age ::\t#{@age}"
  end

  def self.register(name, age, college_student_id, course_student_id)
    student = Student.new(name, age, college_student_id, course_student_id)
    student_record = student.to_array
    CSV.open('student.csv', 'a') { |csv| csv << student_record }
  end

  def self.all
    print "Student details ::\n\n"
    puts "StudentID\tName\tAge"
    CSV.foreach('student.csv', 'r').with_index(1) do |record, ln|
      puts "#{ln}\t\t#{record[0].capitalize}\t#{record[1]}"
    end
    puts
  end

  #
  # finds college and course of the student
  #
  # @param [int] student_id
  #
  # @return student's college and course enrolled details
  #
  def self.find(student_id)
    print "\nStudent details ::\n\n"
    CSV.foreach('student.csv', 'r').with_index(1) do |record, ln|
      if ln == student_id
        Student.new(record[0].capitalize, record[1], record[2], record[3]).print
        College.find(record[2].to_i)
        Course.find(record[3].to_i)
      end
    end
  end
end
