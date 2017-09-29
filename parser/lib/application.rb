require_relative 'parser'

#
# Class Application provides interface for parsing
#
# @author Maanav Shah <maanav@amuratech.com>
#
class Application
  def show_menu
    puts
    puts 'Html Parser ::'
    puts '1. Parse Html File'
    puts '2. Print Parsed Tree'
    puts '3. Print Tags'
    puts '4. Search By Id'
    puts '5. Exit'
    print 'Enter Choice :: '
  end

  def print_attributes(attributes)
    puts 'Attributes => '
    attributes.each { |att| puts "\t#{att.key} -> #{att.value}" }
  end

  def print_node(node)
    return puts 'No such ID found!' if node.nil?
    puts 'ID Found ::'
    puts "Tag\t=> #{node.tag}"
    puts "Parent Tag => #{node.parent.tag}"
    print_attributes(node.attributes)
    puts "Content\t=> #{node.content.data}"
  end

  def launch
    bool = true
    parsed = false
    parser = nil
    while bool
      show_menu
      choice = gets.chomp.to_i
      if !parsed && choice != 1
        puts 'Parse html file first!'
      else
        case choice
        when 1
          parser, parsed = parse_by_file
        when 2
          print "\nHtml Tree ::\n"
          parser.print_tree
        when 3
          print "\nHtml Tree Tags ::\n"
          parser.return_all_tags
        when 4
          content_by_id(parser)
        when 5
          puts 'Exiting!'
          bool = false
        else
          puts 'Invalid Choice!'
        end
      end
    end
  end

  def parse_by_file
    print 'Enter file name :: '
    file_name = gets.chomp
    parser = Parser.new(file_name)
    parser.parse_tree
    puts 'Html File Parsed!'
    [parser, true]
  end

  def content_by_id(parser)
    puts 'Enter id to search ::'
    node = parser.return_content_by_id(gets.chomp)
    print_node(node)
  end
end
