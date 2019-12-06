require 'csv'

csv = CSV.read('csv.csv', col_sep: ';', row_sep: :auto, headers: true, encoding: 'ASCII')

TYPES = csv.headers
puts TYPES

integer_longest_value = '1'
string_longest_value = ''
money_longest_value = '0.0'

csv.each do |line|
  line[TYPES.index('int')].split(' ').each { |a| integer_longest_value = a if a.length > integer_longest_value.length }
  line[TYPES.index('string')].split(' ').each { |a| string_longest_value = a if a.length > string_longest_value.length }
  line[TYPES.index('money')].split(' ').each { |a| money_longest_value = a if a.length > money_longest_value.length }
end

puts integer_longest_value.length
puts string_longest_value.length
puts money_longest_value.length
