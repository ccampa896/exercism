module Chess
  RANKS = 1..8
  FILES = 'A'..'H'

  def self.valid_square?(rank, file)
    RANKS.include?(rank) && FILES.include?(file)
  end

  def self.nickname(first_name, last_name)
    first_name.upcase[..1] + last_name.upcase[-2..]
  end

  def self.move_message(first_name, last_name, square)
    nick = nickname(first_name, last_name)
    if valid_square?(square[1].to_i, square[0])
      "#{nick} moved to #{square}"
    else
      "#{nick} attempted to move to #{square}, but that is not a valid square"
    end
  end
end
