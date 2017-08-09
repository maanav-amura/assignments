#  return the highest and lowest number from a string of space separated numbers
def high_and_low(array = '')
  return nil if array.empty?
  array = array.split(' ').map(&:to_i)
  "#{array.max} #{array.min}"
end

puts high_and_low('1 2 -3 4 5')
puts high_and_low('1 2 3 011 10')
puts high_and_low('1 -100 3000 1000 10')
puts high_and_low

# output
# 5 -3
# 11 1
# 3000 -100
#
