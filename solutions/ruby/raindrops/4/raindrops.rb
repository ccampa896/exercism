Raindrops = {
  3 => 'Pling',
  5 => 'Plang',
  7 => 'Plong'
}

def Raindrops.convert(number)

  sounds = each_with_object(String.new) do |(divisor, sound), result_string|
    result_string << sound if (number % divisor).zero?
  end

  sounds.empty? and number.to_s or sounds

end
