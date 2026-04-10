Isogram = BasicObject.new

def Isogram.isogram?(phrase)
  letters = phrase.downcase.scan(/[a-z]/)

  letters.uniq.length == letters.length
end
