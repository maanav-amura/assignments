# solution({a: 1, b: '2'}) # should return "a = 1,b = 2"

hash = { :font_size => 10, :font_family => "Arial" }
puts 'Hash :: '
puts hash.map { |k, v| "#{k} = #{v}" }.join(', ')
