require 'logger'

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
  attr_accessor :rules, :logger

  def initialize(number, rules: RULES, logger: Logger.new(IO::NULL))
    self.number = number
    self.rules = rules
    self.logger = logger

    logger.debug(
      'Initializing Raindrop with number=%<number>p, rules=%<rules>p' % {
        number:,
        rules:,
      }
    )
    self.to_s = sound_or_number.to_s
  end

  def chord
    @chord ||= rules.each_with_object(+'') do |(divisor, note), chord|
      next unless (number % divisor).zero?

      logger.debug(
        'Rule matched: %<number>p divisible by %<divisor>p -> %<note>p' % {
          number:,
          divisor:,
          note:,
        }
      )
      chord << note
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

  # Explicit integer conversion (guarantees an Integer even for Float/Rational)
  def to_i
    number.to_i
  end

  # Numeric type coercion (Double-Dispatch for math operations)
  def coerce(other_number)
    [other_number, number]
  end
end

# CLIENT SCRIPT & CLI LOGGING CONTROL
# rubocop:disable Layout/LineLength
# Examples:
#   ruby raindrops.rb                                               # Prints help screen
#   ruby raindrops.rb 15 28 34                                      # Converts numbers (logs off)
#   ruby raindrops.rb 15 --log-level info                           # High-level audit to stderr
#   ruby raindrops.rb 15 105 --log-level debug --log-target stdout  # Full forensics to stdout
#   ruby raindrops.rb 15.7 --log-level debug --log-target audit.log # Full forensics to file
# rubocop:enable Layout/LineLength
if $PROGRAM_NAME == __FILE__
  require 'optparse'

  options = {
    level: Logger::WARN,
    target: $stderr,
  }

  parser = OptionParser.new do |opts|
    opts.banner = 'Usage: ruby raindrops.rb [options] NUMBER [NUMBER ...]'

    opts.on(
      '--log-level LEVEL',
      %w[debug info warn error fatal],
      'Set log level (debug, info, warn, error, fatal)'
    ) do |lvl|
      options[:level] = Logger.const_get(lvl.upcase)
    end

    opts.on(
      '--log-target TARGET',
      'Set log output target (stdout, stderr, or file path)'
    ) do |tgt|
      options[:target] = case tgt.downcase
                         when 'stdout' then $stdout
                         when 'stderr' then $stderr
                         else tgt
                         end
    end

    opts.on('-h', '--help', 'Prints this help') do
      puts opts
      exit
    end
  end

  parser.parse!

  if ARGV.empty?
    puts parser
    exit
  end

  logger = Logger.new(options[:target], progname: 'RaindropsAudit')
  logger.level = options[:level]
  logger.formatter = proc do |severity, _datetime, progname, msg|
    "[%<progname>s] %<severity>-5s : %<msg>s\n" % {progname:, severity:, msg:}
  end

  logger.info('Starting Raindrops CLI execution...')

  ARGV.each do |arg|
    number = Integer(arg, exception: false) || Float(arg, exception: false)

    unless number
      logger.warn('Skipping invalid numeric input: %<arg>p' % {arg:})
      next
    end

    drop = Raindrops.new(number, logger:)
    puts '%<number>s => %<drop>s' % {number:, drop:}

    logger.info('Converted %<number>p to %<drop>p' % {number:, drop:})
    logger.debug(
      'Audit -> raw: %<raw>p, to_i: %<int>p, 10 + drop: %<sum>p' % {
        raw: drop.number,
        int: drop.to_i,
        sum: 10 + drop,
      }
    )
  end
end
