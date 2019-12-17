require 'csv'
require_relative 'app/converter'
require_relative 'app/width_calculator'

Dir[File.join(__dir__, 'app','services', '*.rb')].each { |file| require file }

module App
  INT_MIN = 1
  STR_MIN = 0
  MONEY_MIN = 3
  OUTPUT = []
end

csv = CSVReader.new.execute

width_calculator = App::WidthCalculator.new(csv)
width_calculator.execute

App::Converter.new(csv, width_calculator).execute
