module EliudsEggs
  extend self

  def egg_count(number)
    number.to_s(2).count('1')
  end

end

if $PROGRAM_NAME == __FILE__
  puts 'Several ways to express the same number of eggs in Ruby:'

  formats = {
    'Decimal'     => '%d',
    'Binary'      => '0b%b',
    'Octal'       => '0o%o',
    'Hexadecimal' => '0x%X'
  }

  number = 42

  max_name_len = formats.keys.map(&:size).max
  max_val_len  = formats.values.map { |directive| (directive % number).size }.max

  formats.each do |base_name, directive|
    line = "%-*s: %-*s = %d eggs" % [
      max_name_len, base_name,
      max_val_len, (directive % number),
      EliudsEggs.egg_count(number)
    ]

    puts line
  end

end
