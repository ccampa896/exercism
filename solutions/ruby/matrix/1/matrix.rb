class Matrix

  private

  attr_writer :rows, :columns

  def initialize(matrix_string)
    self.rows = matrix_string.split("\n").map { |row| row.split.map(&:to_i) }
    self.columns = rows.transpose
  end

  public

  attr_reader :rows

  def row(index)
    rows[index - 1]
  end

  def column(index)
    @columns[index - 1]
  end

end
