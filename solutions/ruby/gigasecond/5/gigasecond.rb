module Gigasecond

  GIGASECOND = Rational(10**9)

  def from(moment)
    moment + GIGASECOND
  end

  module_function :from

end

if $PROGRAM_NAME == __FILE__
  # --- Easter Egg: The Unix Epoch Trivia ---
  epoch = Time.at(0)

  puts <<~TRIVIA
    🌟 --- Trivia: The Unix Epoch --- 🌟
    Did you know? If we add exactly one gigasecond to the dawn of Unix time...
    Start Moment:     #{epoch}
    Gigasecond Later: #{Gigasecond.from(epoch)}

  TRIVIA

  # --- Standard Domain Demonstration ---
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
