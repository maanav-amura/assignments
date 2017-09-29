#
# Class Attribute provides attributes for node
#
# @author Maanav Shah <maanav@amuratech.com>
#
class Attribute
  attr_accessor :key, :value

  def initialize(key, value)
    @key = key
    @value = value
  end
end
