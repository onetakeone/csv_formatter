module App
  class Converter
    def initialize(csv, width_calculator)
      @csv = csv
      @columns = csv.headers
      @integer_width = width_calculator.integer_width
      @string_width = width_calculator.string_width
      @money_width = width_calculator.money_width
    end

    def execute
      OUTPUT << initial_line

      @csv.each do |line|
        OUTPUT << first_line(line)

        line[@columns.index('string')].split(' ').each_with_index do |string_value, index|
          unless index == 0
            OUTPUT << n_line(string_value)
          end
        end

        OUTPUT << end_line
      end

      OUTPUT.each { |line| puts line }
    end

    private

    def initial_line
      '+' + '-' * @integer_width + \
      '-' + '-' * @string_width + \
      '-' + '-' * @money_width + \
      '+'
    end

    def first_line(line)
      '|'+ line[@columns.index('int')].rjust(@integer_width) + \
      '|' + line[@columns.index('string')][0].ljust(@string_width) + \
      '|' + line[@columns.index('money')].rjust(@money_width) + \
      '|'
    end

    def n_line(string_value)
      '|' + ' ' * @integer_width + \
      '|' + string_value.ljust(@string_width) + \
      '|' + ' ' * @money_width + \
      '|'
    end

    def end_line
      '+' + '-' * @integer_width + \
      '+' + '-' * @string_width + \
      '+' + '-' * @money_width + \
      '+'
    end
  end
end
