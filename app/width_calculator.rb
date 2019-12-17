module App
  class WidthCalculator
    def initialize(csv)
      @csv = csv
      @columns = csv.headers
      @integer_width = INT_MIN
      @string_width = STR_MIN
      @money_width = MONEY_MIN
    end

    def execute
      @csv.each do |line|
        @integer_width = line[@columns.index('int')].length if line[@columns.index('int')].length > @integer_width

        line[@columns.index('string')].split(' ').each { |a| @string_width = a.length if a.length > @string_width }

        line[@columns.index('money')] = MoneyFormatter.new(line[@columns.index('money')]).execute
        @money_width = line[@columns.index('money')].length if line[@columns.index('money')].length > @money_width
      end
    end

    def integer_width
      @integer_width
    end

    def string_width
      @string_width
    end

    def money_width
      @money_width
    end
  end
end
