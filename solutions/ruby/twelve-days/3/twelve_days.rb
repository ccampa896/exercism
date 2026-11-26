class TwelveDays

  DEFAULT_SONG_FILE = File.expand_path('song.txt', __dir__)

  def self.song
    new.song
  end

  private

  attr_accessor :source

  def initialize(source: DEFAULT_SONG_FILE)
    self.source = source
  end

  public

  def song
    source.respond_to?(:read) ? source.read : File.read(source)
  end
end

if $PROGRAM_NAME == __FILE__
  require 'optparse'

  source = TwelveDays::DEFAULT_SONG_FILE

  OptionParser.new do |opts|
    opts.banner = 'Usage: ruby twelve_days.rb [options]'

    opts.on(
      '-f', '--file PATH',
      'Path to a custom lyrics file'
    ) do |path|
      source = path
    end

    opts.on(
      '-i', '--stdin',
      'Read lyrics from standard input (Ctrl+D to finish)'
    ) do
      source = $stdin
    end

    opts.on('-h', '--help', 'Prints this help') do
      puts opts
      exit
    end
  end.parse!

  puts TwelveDays.new(source:).song

end
