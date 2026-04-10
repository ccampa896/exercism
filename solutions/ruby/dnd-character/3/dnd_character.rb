class DndCharacter

  ATTRS = ATTRIBUTES = %i[
    strength dexterity constitution intelligence wisdom charisma
  ]

  private_constant :ATTRS

  def self.modifier(score)
    ((score - 10) / 2.0).floor
  end

  attr_reader(*ATTRIBUTES)

  def initialize
    ATTRS.each do |attr|
      instance_variable_set("@#{attr}", roll_ability)
    end
  end

  def hitpoints
    10 + self.class.modifier(constitution)
  end

  private

  def roll_ability
    Cup.new(4, sides: 6).highest(3).total
  end

  class Cup
    def initialize(count, sides:)
      @dice = Array.new(count) { Die.new(sides) }
    end

    def highest(n)
      @results = @dice.map(&:roll).max(n)
      self
    end

    def total
      @results.sum
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
