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

  formats.each do |base_name, directive|
    formatted_number = sprintf(directive, number)

    puts "#{base_name.ljust(11)}: #{formatted_number.ljust(8)} = #{EliudsEggs.egg_count(number)} eggs"
  end

end
