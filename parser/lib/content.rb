#
# Class Content provides content in html tag
#
# @author Maanav Shah <maanav@amuratech.com>
#
class Content
  attr_accessor :data, :tag

  #
  # initializes the data and tag
  #
  # @param [<type>] data is the content of tag
  # @param [<type>] tag is the tag from which data is obtained
  #
  def initialize(data, tag)
    @data = data
    @tag = tag
  end
end
