require_relative 'node'
require_relative 'stack'

#
# Class Parser provides parsing for a html file
#
# @author Maanav Shah <maanav@amuratech.com>
#
class Parser
  attr_accessor :html_file, :root, :tags

  def initialize(html_file)
    @html_file = html_file
    @tags = []
  end

  #
  # Parses html file and generates tree
  #
  #
  # @return root
  #
  def parse_tree
    File.open(html_file, 'r') do |file|
      current = nil
      file.each_line do |line|
        line.scan(%r{(<(.*?>.*?)<(\/.*?)>|<(.*?)>(.*))}).each do |tag|
          if !tag[3].nil? && tag[3].start_with?('/') # ending tag
            current = current.parent
          else
            node = Node.new(tag)
            if @root.nil?
              @root = node
            else
              node.parent = current
              current.childs << node
            end
            @tags << node.tag
            current = node
            current = current.parent if !tag[2].nil? && tag[2].start_with?('/')
          end
        end
      end
    end
  end

  #
  # prints the parsed tree
  #
  #
  # @return [<type>] <description>
  #
  def print_tree
    current = nil
    stack = Stack.new
    stack.push(@root)
    until stack.empty?
      current = stack.pop
      if current.parent.nil?
        puts current.tag
      else
        puts "#{current.tag}\t<=\t#{current.parent.tag}"
      end
      unless current.childs.size.zero?
        current.childs.reverse_each { |child| stack.push(child) }
      end
    end
  end

  #
  # returns all the unique tag in tree
  #
  #
  # @return [<type>] <description>
  #
  def return_all_tags
    @tags.uniq.each { |tag| puts tag }
  end

  #
  # returns the tags, parent and attributes of node
  #
  # @param string id tag id of the node
  #
  # @return node
  #
  def return_content_by_id(id)
    current = nil
    stack = Stack.new
    stack.push(@root)
    until stack.empty?
      current = stack.pop
      return current if current.id.eql?(id)
      unless current.childs.size.zero?
        current.childs.reverse_each { |child| stack.push(child) }
      end
    end
  end
end
