#
# Class Node provides node structure for tree hierarchy
#
# @author Maanav Shah <maanav@amuratech.com>
#
class Node
  attr_accessor :tag, :id, :attributes, :parent, :childs

  def initialize(tag)
    @tag = tag.scan(/^[^\s]+/).first
    @attributes = {}
    @childs = []
    parse_tag(tag)
  end

  private

  def parse_tag(tag)
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
