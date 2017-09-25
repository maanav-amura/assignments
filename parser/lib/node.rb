#
# Class Node provides node structure for tree hierarchy
#
# @author Maanav Shah <maanav@amuratech.com>
#
class Node
  attr_accessor :tag, :id, :attributes, :content, :parent, :childs

  #
  # extracts tag, contents and attributes
  #
  # @param tag contains tags and contents
  #
  def initialize(tag)
    unless tag[1].nil?
      @tag = tag[1].scan(/(^[^\s+|>]+)/).first.first
      @content = tag[1].scan(/>(.*)/).first.first
      parse_tag(tag[1])
    else
      @tag = tag[3].scan(/^[^\s]+/).first
      parse_tag(tag[3])
    end
    @childs = []
  end

  private

  #
  # parse class, id and other at
  #
  # @param [<type>] tag <description>
  #
  # @return [<type>] <description>
  #
  def parse_tag(tag)
    @attributes = {}
    value = tag.scan(/"(.*?)"/)
    tag.scan(/([\s].*?=)/).each_with_index do |k, index|
      property = k.first.strip.chop.downcase
      if %w[class id].include?(property)
        @id = value[index].first
      else
        @attributes[property] = value[index].first
      end
    end
  end
end
