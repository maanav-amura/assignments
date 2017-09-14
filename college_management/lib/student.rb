class Student
  attr_accessor :name, :age, :college_id, :course_id

  def self.register(name, age, college_id, course_id)
    student_record = [name, age, college_id, course_id]
    CSV.open('student.csv', 'a') { |csv| csv << student_record }
  end

  def self.all
    print "Student details ::\n\n"
    puts "StudentId\tName\tAge"
    CSV.foreach('student.csv', 'r').with_index(1) { |record, ln| puts "#{ln}\t\t#{record[0].capitalize}\t#{record[1]}" }
    puts
  end

  def self.find(id)
    print "\nStudent details ::\n\n"
    puts "Name\tAge"
    CSV.foreach('student.csv', 'r').with_index(1) do |record, ln|
      if ln == id
        puts "#{record[0].capitalize}\t#{record[1]}"
        College.find(record[2].to_i)
        Course.find_course(record[3].to_i)
      end
    end
  end
end
