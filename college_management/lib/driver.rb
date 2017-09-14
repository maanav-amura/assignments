require_relative 'college'
require_relative 'course'
require_relative 'student'

class Driver
  def launch!
    input = ''
    until input == 7
      menu
      input = gets.chomp.to_i
      puts
      case input
      when 1
        register_college
      when 2
        register_course
      when 3
        register_student
      when 4
        search_college
      when 5
        search_course
      when 6
        search_student
      when 7
        exit
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
    puts '7. Quit'
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
    puts 'Enter Course Name: '
    name = gets.chomp
    College.all
    puts 'Enter CollegeID to register course: '
    college_id = gets.chomp
    Course.register(name, college_id)
    puts "\nCourse #{name.upcase} Registered!"
  end

  def register_student
    puts 'Enter Student name: '
    name = gets.chomp
    puts 'Enter Student age: '
    age = gets.chomp
    College.all
    puts 'Enter CollegeID to register Student: '
    college_id = gets.chomp
    Course.all
    puts 'Enter CourseID to register Student: '
    course_id = gets.chomp.to_i
    Student.register(name, age, college_id, course_id)
    puts "Student #{name.capitalize} Registered"
  end

  def search_college
    College.all
    puts 'Enter CollegeID to Search: '
    id = gets.chomp.to_i
    Course.find(id)
  end

  def search_course
    Course.all
    puts 'Enter CourseID to Search: '
    id = gets.chomp.to_i
    Course.find_college(id)
  end

  def search_student
    Student.all
    puts 'Enter StudentID to Search: '
    id = gets.chomp.to_i
    Student.find(id)
  end
end
