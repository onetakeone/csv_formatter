class CSVReader
  def initialize(csv)
    @csv = csv
  end

  def execute
    CSV.read(@csv, col_sep: ';', row_sep: :auto, headers: true, encoding: 'ASCII')
  end
end
