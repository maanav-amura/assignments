require_relative 'college'
require_relative 'course'
require_relative 'student'
require_relative 'error'

#
# Class App provides application interface for college management
#
# @author Maanav Shah <maanav@amuratech.com>
#
class App
  include Error

  REGEX = /^[1-9][0-9]$/

  def launch!
    input = ''
    until input == 10
      menu
      input = gets.chomp.to_i
      puts
      case input
      when 1 then register_college
      when 2 then register_course
      when 3 then register_student
      when 4 then search_college
      when 5 then search_course
      when 6 then search_student
      when 7 then list_colleges
      when 8 then list_courses
      when 9 then list_students
      when 10 then exit
      else
        puts 'Invalid Input! Enter again!'
      end
    end
  end

  def menu
    puts "\nWelcome!"
    puts '1. Register College'
    puts '2. Register Course'
    puts '3. Register Student'
    puts '4. Search College'
    puts '5. Search Course'
    puts '6. Search Student'
    puts '7. List College'
    puts '8. List Course'
    puts '9. List Student'
    puts '10. Quit'
    print 'Enter Choice :: '
  end

  def register_college
    puts 'Enter College Name: '
    name = gets.chomp
    puts 'Enter College City: '
    city = gets.chomp
    College.register(name, city)
    puts "\nCollege #{name.capitalize} Registered!"
  end

  def register_course
    if College.count.zero?
      puts 'Register a college first!'
      return
    end
    puts 'Enter Course Name: '
    name = gets.chomp
    College.all
    puts 'Enter CollegeID to register course: '
    college_id = get_college
    Course.register(name, college_id)
    puts "\nCourse #{name.upcase} Registered!"
  end

  def get_age(age = '')
    until age.match?(REGEX)
      begin
        puts 'Enter Student age: '
        age = gets.chomp
        raise AgeError unless age.match?(REGEX)
      rescue AgeError => exception
        exception.message
      else
        return age
      end
    end
  end

  def get_college
    College.all
    puts 'Enter CollegeID to register Student: '
    college_id = gets.chomp.to_i
    while college_id < 0 || college_id > College.count
      puts 'Enter CollegeID to register Student: '
      college_id = gets.chomp.to_i
    end
    return college_id
  end

  def get_course
    Course.all
    puts 'Enter CourseID to register Student: '
    course_id = gets.chomp.to_i
    while course_id <= 0 || course_id > Course.count
      puts 'Enter CourseID to register Student: '
      course_id = gets.chomp.to_i
    end
    return course_id
  end

  def register_student
    if College.count.zero?
      puts 'Register a college first!'
      return
    elsif Course.count.zero?
      puts 'Register a course first!'
      return
    end
    puts 'Enter Student name: '
    name = gets.chomp
    age = get_age
    college_id = get_college
    course_id = get_course
    Student.register(name, age, college_id, course_id)
    puts "Student #{name.capitalize} Registered"
  end

  def list_colleges
    College.all
  end

  def list_courses
    Course.all
  end

  def list_students
    Student.all
  end

  def search_college
    College.all
    puts 'Enter CollegeID to Search: '
    college_id = gets.chomp.to_i
    College.find_college_courses(college_id)
  end

  def search_course
    Course.all
    puts 'Enter CourseID to Search: '
    course_id = gets.chomp.to_i
    Course.find_course_college(course_id)
  end

  def search_student
    Student.all
    puts 'Enter StudentID to Search: '
    student_id = gets.chomp.to_i
    Student.find(student_id)
  end
end
