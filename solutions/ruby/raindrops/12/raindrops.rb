class Raindrops

  RULES = {
    3 => 'Pling',
    5 => 'Plang',
    7 => 'Plong',
  }

  def self.convert(number)
    new(number).to_s
  end

  private

  attr_writer :number, :to_s
  attr_accessor :rules

  def initialize(number, rules: RULES)
    self.number = number
    self.rules = rules
    self.to_s = sound_or_number.to_s
  end

  def chord
    @chord ||= rules.each_with_object(+'') do |(divisor, note), chord|
      chord << note if (number % divisor).zero?
    end
  end

  def sound_or_number
    chord.empty? ? number : chord
  end

  public

  attr_reader :number, :to_s

  # Explicit integer conversion
  def to_i
    number
  end

  # Numeric type coercion (Double-Dispatch for math operations)
  def coerce(other_number)
    [other_number, number]
  end

end


# TEST AND FORENSIC AUDIT BLOCK
# Run normally: `ruby raindrops.rb` (INFO level)
# Run in forensic mode: `ruby --debug raindrops.rb` (DEBUG level)
if $PROGRAM_NAME == __FILE__
  require 'logger'

  logger = Logger.new($stdout, progname: 'RaindropsAudit')
  logger.level = $DEBUG ? Logger::DEBUG : Logger::INFO
  logger.formatter = proc do |severity, _datetime, progname, msg|
    "[%<progname>s] %<severity>-5s : %<msg>s\n" % {progname:, severity:, msg:}
  end

  logger.info('Starting the Traceability (Forensics) demonstration...')

  drop = Raindrops.new(15)

  # Implicitly calls drop.to_s via string formatting (%s)
  logger.info('The processed sound was: %<drop>s' % {drop:})
  # Expected: "PlingPlang"

  # Testing custom camp rules with non-prime factors (8 and 10)
  camp_rules = {8 => 'Suzy', 10 => 'Billy', 15 => 'Camp!'}
  suzy_drop = Raindrops.new(8, rules: camp_rules)
  billy_drop = Raindrops.new(10, rules: camp_rules)
  logger.info('Suzy (8) custom rule: %<suzy_drop>s' % {suzy_drop:})
  logger.info('Billy (10) custom rule: %<billy_drop>s' % {billy_drop:})
  # Expected: "Suzy", "Billy"

  # 0 is evenly divisible by all non-zero numbers
  zero_drop = Raindrops.new(0)
  logger.info('The sound for 0 (tests all rules) was: %<zero_drop>s' % {zero_drop:})
  # Expected: "PlingPlangPlong"

  logger.info('Double Dispatch Math demonstration...')

  [3, 5, 7, 15, 30, 45, 105].each do |number|
    sample_drop = Raindrops.new(number)
    math_result = 10 + sample_drop

    logger.info(
      'For number %<number>p: 10 + %<sample_drop>s = %<math_result>d' % {
        number:,
        sample_drop:,
        math_result:,
      }
    )

    logger.debug(
      'Internal state check -> object_id: %<id>d, raw number: %<num>p' % {
        id: sample_drop.object_id,
        num: sample_drop.number,
      }
    )
  end

  # Forensic Audit: Only visible when running with `ruby -d` or `ruby --debug`
  logger.debug('Forensic Audit - The original number was: %<number>p' % {number: drop.number})
  # Expected: 15
end
