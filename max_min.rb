#  return the highest and lowest number from a string of space separated numbers
def high_and_low(array)
  "#{array.split(' ').min} #{array.split(' ').max}"
end

puts high_and_low('1 2 3 4 5')
puts high_and_low('1 2 -3 4 5')
puts high_and_low('1 9 3 4 -5')

#output
# 1 5
# -3 5
# -5 9
