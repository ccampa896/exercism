Raindrops = BasicObject.new

def Raindrops.convert(number)

  rules = { 3 => 'Pling', 5 => 'Plang', 7 => 'Plong' }

  sounds = rules.each_with_object(String.new) do |(divisor, sound), result_string|
    result_string << sound if (number % divisor).zero?
  end

  sounds.empty? and number.to_s or sounds

end
