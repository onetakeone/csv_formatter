require 'csv'

def format_money(number)
  whole_part, decimal_part = number.split('.')
  [whole_part.gsub(/(\d)(?=\d{3}+$)/, '\1 '), decimal_part].compact.join('.')
end

csv = CSV.read('csv.csv', col_sep: ';', row_sep: :auto, headers: true, encoding: 'ASCII')

OUTPUT = []
TYPES = csv.headers

### LENGTH

integer_longest_value = '1'
string_longest_value = ''
money_longest_value = '0.0'

csv.each do |line|
  integer_longest_value = line[TYPES.index('int')] if line[TYPES.index('int')].length > integer_longest_value.length

  line[TYPES.index('string')].split(' ').each { |a| string_longest_value = a if a.length > string_longest_value.length }

  money_longest_value = format_money(line[TYPES.index('money')]) if format_money(line[TYPES.index('money')]).length > money_longest_value.length
end

OUTPUT << '+' + '-' * integer_longest_value.length + '-' + '-' * string_longest_value.length + '-' + '-' * money_longest_value.length + '+'

csv.each do |line|
  ## integer
  int_length_index = integer_longest_value.length - line[TYPES.index('int')].length
  int_output = if int_length_index == 0
    line[TYPES.index('int')]
  else
    ' ' * int_length_index + line[TYPES.index('int')]
  end

  ## first string
  string_length_index = string_longest_value.length - line[TYPES.index('string')][0].length
  str_output = if string_length_index == 0
    line[TYPES.index('string')][0]
  else
    line[TYPES.index('string')][0] + ' ' * string_length_index
  end

  ## money
  money_length_index = money_longest_value.length - format_money(line[TYPES.index('money')]).length
  money_output = if money_length_index == 0
    format_money(line[TYPES.index('money')])
  else
    ' ' * money_length_index + format_money(line[TYPES.index('money')])
  end

  OUTPUT << '|'+ int_output + '|' + str_output + '|' + money_output + '|'

  line[TYPES.index('string')].split(' ').each_with_index do |string_value, index|
    string_length_index = string_longest_value.length - string_value.length
    str_output = if string_length_index == 0
      string_value
    else
      string_value + ' ' * string_length_index
    end

    unless index == 0
      OUTPUT << '|' + ' ' * integer_longest_value.length + '|' + str_output + '|' + ' ' * money_longest_value.length + '|'
    end
  end

  OUTPUT << '+' + '-' * integer_longest_value.length + '+' + '-' * string_longest_value.length + '+' + '-' * money_longest_value.length + '+'
end

OUTPUT.each { |l| puts l }

