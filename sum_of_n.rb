require 'benchmark'

# returns an Array of length abs(n) + 1
# produced by taking sum of consecutive integer numbers from 0 to n inclusive
def sum_of_n(n = nil)
  return nil unless n.is_a?(Integer)
  sum = 0
  Array.new(n.abs + 1) { |index| n.negative? ? sum -= index : sum += index }
end

p sum_of_n(5)   # [0, 1, 3, 6, 10, 15]
p sum_of_n(-5)  # [0, -1, -3, -6, -10, -15]
p sum_of_n(11)  # [0, 1, 3, 6, 10, 15, 21, 28, 36, 45, 55, 66]
p sum_of_n(-7)  # [0, -1, -3, -6, -10, -15, -21, -28]
p sum_of_n(nil) # nil
p sum_of_n(0)   # [0]
p sum_of_n(-1)  # [0, -1]
p sum_of_n('')  # nil
p Benchmark.measure{sum_of_n(5)}
# <Benchmark::Tms:0x00000001ba0850 @label="", @real=6.889999895065557e-06, @cstime=0.0, @cutime=0.0, @stime=0.0, @utime=0.0, @total=0.0>
