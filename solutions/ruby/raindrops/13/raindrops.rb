require 'logger'

class Raindrops
  RULES = {
    3 => 'Pling',
    5 => 'Plang',
    7 => 'Plong',
  }

  def self.convert(number, logger: Logger.new(IO::NULL))
    new(number, logger:).to_s
  end

  private

  attr_writer :number, :to_s
  attr_accessor :rules, :logger

  def initialize(number, rules: RULES, logger: Logger.new(IO::NULL))
    self.number = number
    self.rules = rules
    self.logger = logger

    logger.debug("Initializing Raindrop with number=#{number.inspect} and rules=#{rules.inspect}")
    self.to_s = sound_or_number.to_s
  end

  def chord
    @chord ||= rules.each_with_object(+'') do |(divisor, note), chord|
      if (number % divisor).zero?
        logger.debug("Rule matched: #{number} is divisible by #{divisor} -> adding '#{note}'")
        chord << note
      end
    end
  end

  def silence?
    chord.empty?
  end

  def sound_or_number
    silence? ? number : chord
  end

  public

  attr_reader :number, :to_s

  # Explicit integer conversion (guarantees an Integer even if initialized with Float/Rational)
  def to_i
    number.to_i
  end

  # Numeric type coercion (Double-Dispatch for math operations)
  def coerce(other_number)
    [other_number, number]
  end
end


# CLIENT SCRIPT & CLI LOGGING CONTROL
# Examples:
#   ruby raindrops.rb                                      # Silent by default (WARN level)
#   ruby raindrops.rb --log-level info                     # High-level audit to stdout
#   ruby raindrops.rb --log-level debug --log-target stderr # Full forensics to stderr
#   ruby raindrops.rb --log-level debug --log-target audit.log # Full forensics to file
if $PROGRAM_NAME == __FILE__
  require 'optparse'

  options = {
    level: Logger::WARN, # Off/silent by default for normal runs
    target: $stdout,
  }

  OptionParser.new do |opts|
    opts.banner = 'Usage: ruby raindrops.rb [options]'

    opts.on('--log-level LEVEL', %w[debug info warn error fatal], 'Set log level (debug, info, warn, error, fatal)') do |lvl|
      options[:level] = Logger.const_get(lvl.upcase)
    end

    opts.on('--log-target TARGET', 'Set log output target (stdout, stderr, or file path)') do |tgt|
      options[:target] = case tgt.downcase
                         when 'stdout' then $stdout
                         when 'stderr' then $stderr
                         else tgt
                         end
    end
  end.parse!

  logger = Logger.new(options[:target], progname: 'RaindropsAudit')
  logger.level = options[:level]
  logger.formatter = proc do |severity, _datetime, progname, msg|
    "[%<progname>s] %<severity>-5s : %<msg>s\n" % {progname:, severity:, msg:}
  end

  logger.info('Starting the Traceability (Forensics) demonstration...')

  drop = Raindrops.new(15, logger:)
  logger.info('The processed sound was: %<drop>s' % {drop:})

  # Testing custom camp rules with non-prime factors (8 and 10)
  camp_rules = {8 => 'Suzy', 10 => 'Billy', 15 => 'Camp!'}
  suzy_drop = Raindrops.new(8, rules: camp_rules, logger:)
  billy_drop = Raindrops.new(10, rules: camp_rules, logger:)
  logger.info('Suzy (8) custom rule: %<suzy_drop>s' % {suzy_drop:})
  logger.info('Billy (10) custom rule: %<billy_drop>s' % {billy_drop:})

  # 0 is evenly divisible by all non-zero numbers
  zero_drop = Raindrops.new(0, logger:)
  logger.info('The sound for 0 (tests all rules) was: %<zero_drop>s' % {zero_drop:})

  logger.info('Double Dispatch Math demonstration...')

  [3, 5, 7, 15, 30, 45, 105].each do |number|
    sample_drop = Raindrops.new(number, logger:)
    math_result = 10 + sample_drop

    logger.info(
      'For number %<number>p: 10 + %<sample_drop>s = %<math_result>d' % {
        number:,
        sample_drop:,
        math_result:,
      }
    )
  end

  # Verifying strict Integer conversion even with a Float input
  float_drop = Raindrops.new(15.7, logger:)
  logger.debug("Strict Integer check -> raw: #{float_drop.number.inspect}, to_i: #{float_drop.to_i.inspect}")

  logger.debug('Forensic Audit - The original number was: %<number>p' % {number: drop.number})
end
