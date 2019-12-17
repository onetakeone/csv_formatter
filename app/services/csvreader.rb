class CSVReader
  def execute
    CSV.read('csv.csv', col_sep: ';', row_sep: :auto, headers: true, encoding: 'ASCII')
  end
end
