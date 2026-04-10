class LogLineParser
  def initialize(line)
    @line = line
  end

  def parsed
    @parsed ||= @line.match(/\[(.*?)\]:\s*(.+?)\s*$/)
  end

  def log_level
    parsed && parsed[1].downcase
  end

  def message
    parsed && parsed[2]
  end

  def reformat
    "#{message} (#{log_level})"
  end
end