module App
  class TableConstructor
    def initialize(csv, width_calculations)
      @csv = csv
      @@columns = csv.headers
      @@integer_width = width_calculations.integer_width
      @@string_width = width_calculations.string_width
      @@money_width = width_calculations.money_width
      @table = []
    end

    def execute
      @table << table_initial_line

      @csv.each do |line|
        @table << block_first_line(line)

        line[@@columns.index('string')].split(' ').each_with_index do |string_value, index|
          unless index == 0
            @table << block_n_line(string_value)
          end
        end

        @table << block_end_line
      end

      @table.each { |line| puts line }
    end

    private

    # +----------+
    def table_initial_line
      '+' + '-' * @@integer_width + \
      '-' + '-' * @@string_width + \
      '-' + '-' * @@money_width + \
      '+'
    end

    # | n|xx | yy|
    def block_first_line(line)
      '|'+ line[@@columns.index('int')].rjust(@@integer_width) + \
      '|' + line[@@columns.index('string')][0].ljust(@@string_width) + \
      '|' + line[@@columns.index('money')].rjust(@@money_width) + \
      '|'
    end

    # |  |xx |   |
    def block_n_line(string_value)
      '|' + ' ' * @@integer_width + \
      '|' + string_value.ljust(@@string_width) + \
      '|' + ' ' * @@money_width + \
      '|'
    end

    # +--+---+---+
    def block_end_line
      '+' + '-' * @@integer_width + \
      '+' + '-' * @@string_width + \
      '+' + '-' * @@money_width + \
      '+'
    end
  end
end
