class StrandLengthError < ArgumentError
  def initialize(message = 'strands must be of equal length')
    super
  end
end

Hamming = BasicObject.new

def Hamming.nucleotides(strand1, strand2)
  strand1.chars.zip(strand2.chars)
end

def Hamming.compute(strand1, strand2)
  ::Kernel.raise StrandLengthError unless strand1.length == strand2.length

  nucleotides(strand1, strand2).count { |n1, n2| n1 != n2 }
end
