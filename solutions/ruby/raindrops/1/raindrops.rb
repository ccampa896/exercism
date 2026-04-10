Raindrops = BasicObject.new

def Raindrops.convert(raindrop)

  sounds = ''
  sounds << 'Pling' if raindrop % 3 == 0
  sounds << 'Plang' if raindrop % 5 == 0
  sounds << 'Plong' if raindrop % 7 == 0

  return raindrop.to_s if sounds.size == 0

  sounds

end
