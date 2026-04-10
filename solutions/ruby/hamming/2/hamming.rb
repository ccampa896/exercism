class StrandLengthError < ArgumentError

  def initialize(msg = "strands must be of equal length")
    super
  end

end

Hamming = Object.new

def Hamming.compute(strand1, strand2)

  raise StrandLengthError unless strand1.length == strand2.length

  strand1.chars.zip(strand2.chars).count { |n1, n2| n1 != n2 }

end
