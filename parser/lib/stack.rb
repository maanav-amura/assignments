#
# Class Stack provides stack functions as push, pop, size and empty
#
# @author Maanav Shah <maanav@amuratech.com>
#
class Stack
  def initialize
    @store = []
  end

  def push(element)
    @store.push(element)
    self
  end

  def pop
    @store.pop
  end

  def size
    @store.size
  end

  def empty?
    @store.size.zero?
  end
end
