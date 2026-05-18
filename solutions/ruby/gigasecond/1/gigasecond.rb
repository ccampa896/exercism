module Gigasecond

  SECONDS_IN_GIGASECOND = 10**9
  private_constant :SECONDS_IN_GIGASECOND

  def self.from(moment)
    moment + SECONDS_IN_GIGASECOND
  end
end

# Library Guard
if $PROGRAM_NAME == __FILE__
  require 'time'

  test_moments = [
    Time.utc(2011, 4, 25),
    Time.utc(2015, 1, 24, 22, 0, 0)
  ]

  report = <<~REPORT
    --- Calculating Gigasecond ---
    Start Moment: %<start_time>s
    Gigasecond Later: %<result_time>s

  REPORT

  test_moments.each do |moment|
    puts report % {
      start_time: moment,
      result_time: Gigasecond.from(moment)
    }
  end
end
