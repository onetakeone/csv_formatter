class MoneyFormatter
  def initialize(number)
    @number = number
  end

  def execute
    whole, franctional = @number.split('.')
    [whole.gsub(/(\d)(?=\d{3}+$)/, '\1 '), franctional].compact.join('.')
  end
end
