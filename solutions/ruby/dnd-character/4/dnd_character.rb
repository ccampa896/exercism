module Roller

  class Cup
    attr_reader :results

    def initialize(count, sides:)
      @dice = Array.new(count) { Die.new(sides) }
    end

    def highest(n)
      @results = @dice.map(&:roll).max(n)
      self
    end

    def total
      results.sum
    end
  end

  class Die
    attr_reader :sides

    def initialize(sides)
      @sides = sides
    end

    def roll
      rand(1..sides)
    end
  end
  
end

class DndCharacter

  ATTRS = ATTRIBUTES = %i[
    strength dexterity constitution intelligence wisdom charisma
  ]
  
  private_constant :ATTRS

  def self.modifier(score)
    (score - 10) / 2
  end

  private

  def initialize
    ATTRS.each do |attr|
      send("#{attr}=", roll_ability)
    end
  end

  attr_writer *ATTRS

  def roll_ability
    Roller::Cup.new(4, sides: 6).highest(3).total
  end

  public

  attr_reader *ATTRS

  def hitpoints
    10 + self.class.modifier(constitution)
  end
  
end
