module App
  class WidthCalculations
    attr_reader :integer_width, :string_width, :money_width

    def initialize(csv)
      @csv = csv
      @columns = csv.headers
      @integer_width = INT_MIN
      @string_width = STR_MIN
      @money_width = MONEY_MIN
    end

    def execute
      @csv.each do |line|
        calculate_integer_column_width(line)

        calculate_string_column_width(line)

        format_money_field(line)
        calculate_money_column_width(line)
      end
    end

    private

    def calculate_integer_column_width(line)
      @integer_width = line[@columns.index('int')].length if line[@columns.index('int')].length > @integer_width
    end

    def calculate_string_column_width(line)
      line[@columns.index('string')].split(' ').each { |a| @string_width = a.length if a.length > @string_width }
    end

    def format_money_field(line)
      line[@columns.index('money')] = MoneyFormatter.new(line[@columns.index('money')]).execute
    end

    def calculate_money_column_width(line)
      @money_width = line[@columns.index('money')].length if line[@columns.index('money')].length > @money_width
    end
  end
end
