require_relative 'content'
require_relative 'attribute'
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
    if tag[1].nil?
      @tag = tag[3].scan(/^[^\s]+/).first
      @content = Content.new(tag[4], @tag)
      parse_tag(tag[3])
    else
      @tag = tag[1].scan(/(^[^\s+|>]+)/).first.first
      @content = Content.new(tag[1].scan(/>(.*)/).first.first, @tag)
      parse_tag(tag[1])
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
    @attributes = []
    value = tag.scan(/"(.*?)"/)
    tag.scan(/([\s].*?=)/).each_with_index do |k, index|
      property = k.first.strip.chop.downcase
      if %w[class id].include?(property)
        @id = value[index].first
      else
        @attributes << Attribute.new(property, value[index].first)
      end
    end
  end
end
