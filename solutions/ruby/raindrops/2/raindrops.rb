Raindrops = BasicObject.new

def Raindrops.convert(number)

  sounds = String.new
  sounds << 'Pling' if (number % 3).zero?
  sounds << 'Plang' if (number % 5).zero?
  sounds << 'Plong' if (number % 7).zero?

  sounds.empty? and number.to_s or sounds

end
