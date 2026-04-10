Hamming = Object.new

def Hamming.compute(strand_a, strand_b)
  raise ArgumentError if strand_a.length != strand_b.length

  strand_a.chars.zip(strand_b.chars).count { |a, b| a != b }
end
