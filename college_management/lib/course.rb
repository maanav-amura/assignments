class Course
  attr_accessor :name, :college_id

  def self.register(name, college_id)
    course_record = [name, college_id]
    CSV.open('course.csv', 'a') { |csv| csv << course_record }
  end

  def self.all
    print "\nCourse Details ::\n\n"
    puts "CourseID\tName"
    CSV.foreach('course.csv', 'r').with_index(1) { |record, ln| puts "#{ln}\t\t#{record[0].upcase}" }
    puts
  end

  def self.find(id)
    print "\nCourses Available ::\n\n"
    CSV.foreach('course.csv', 'r') { |record| puts "#{record[0].upcase}" if record[1].to_i == id }
  end

  def self.find_course(id)
    print "\nCourse Details ::\n\n"
    puts "CourseID\tName"
    CSV.foreach('course.csv', 'r').with_index(1) { |record, ln| puts "#{ln}\t\t#{record[0].upcase}" if ln == id }
  end

  def self.find_college(id)
    print "\nCourse included in College ::\n"
    CSV.foreach('course.csv', 'r').with_index(1) { |record, ln| College.find(record[1].to_i) if ln == id }
  end
end
