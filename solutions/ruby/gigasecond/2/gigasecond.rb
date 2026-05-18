module Gigasecond

  GIGASECOND = 1_000_000_000

  def self.from(moment)
    moment + GIGASECOND
  end
end

if $PROGRAM_NAME == __FILE__

  moments = [
    Time.new(2011, 4, 25),
    Time.utc(2015, 1, 24, 22, 0, 0)
  ]

  report = <<~REPORT
    --- Calculating Gigasecond ---
    Start Moment: %<start_time>s
    Gigasecond Later: %<result_time>s

  REPORT

  moments.each do |moment|
    puts report % {
      start_time: moment,
      result_time: Gigasecond.from(moment)
    }
  end

end
