# returns an Array of length abs(n) + 1
# produced by taking sum of consecutive integer numbers from 0 to n inclusive
def sum_of_n(n = nil)
  return nil unless n.is_a?(Integer)
  sum = 0
  Array.new(n.abs + 1) { |index| n.negative? ? sum -= index : sum += index }
end

puts 'Sum of n numbers :: '

n = 5
p sum_of_n(n)
n = -5
p sum_of_n(n)
n = nil
p sum_of_n(n)
n = 0
p sum_of_n(n)
n = -1
p sum_of_n(n)
n = ''
p sum_of_n(n)

# Output ::
#
# Sum of n numbers ::
# [0, 1, 3, 6, 10, 15]
# [0, -1, -3, -6, -10, -15]
# nil
# [0]
# [0, -1]
# nil
