# Module for number formatter
module NumberFormat
  def number_to_currency(number, options ={})
    unit	= options[:unit]	|| '$'
    precision	= options[:precision]	|| 2
    delimiter	= options[:delimiter]	|| ','
    seperator	= options[:seperator]	|| '.'

    seperator = '' if precision.zero?
    integer, decimal = number.to_s.split('.')

    i = integer.length
    until i <= 4
      i -= 4
      integer = integer.insert(i, delimiter)
    end

    if precision.zero?
      precision_decimal = ''
    else
      decimal ||= '0'
      decimal = decimal[0, precision - 1]
      precision_decimal = decimal.ljust(precision, '0')
    end

    unit + integer.chomp + seperator + precision_decimal
  end
end
