module EliudsEggs
  extend self

  def egg_count(number)
    number.to_s(2).count('1')
  end

end

if $PROGRAM_NAME == __FILE__
  puts 'Several ways to express the same number of eggs in Ruby:'

  base_to_format = {
    'Decimal'     => '%d',
    'Binary'      => '0b%b',
    'Octal'       => '0o%o',
    'Hexadecimal' => '0x%X'
  }

  number = 42

  base_name_padding = base_to_format.keys.max_by(&:size).size

  template = '%<eggs>d eggs = %<base>s: %<formatted_value>s'

  base_to_format.each do |base_name, format|
    puts template % {
      eggs: EliudsEggs.egg_count(number),
      base: base_name.ljust(base_name_padding),
      formatted_value: (format % number)
    }
  end

end
