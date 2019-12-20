require 'csv'

Dir['./**/*.rb'].each{ |file| require file unless file == './app.rb' }

module App
  INT_MIN = 1
  STR_MIN = 0
  MONEY_MIN = 3

  def self.convert
    csv = CSVReader.new('csv.csv').execute

    width_calculations = App::WidthCalculations.new(csv)
    width_calculations.execute

    TableConstructor.new(csv, width_calculations).execute
  end
end

App.convert
