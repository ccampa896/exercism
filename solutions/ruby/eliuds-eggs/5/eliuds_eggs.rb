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
  format_code_padding = base_to_format.values.max_by { |format| (format % number).size }.size

  output_template = "%-<base>#{base_name_padding}s: %-<formatted_value>#{format_code_padding}s = %<eggs>d eggs"

  base_to_format.each do |base_name, format|
    puts output_template % {
      base: base_name,
      formatted_value: (format % number),
      eggs: EliudsEggs.egg_count(number)
    }
  end

end
