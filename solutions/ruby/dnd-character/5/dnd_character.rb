module Roller

  class Cup

    attr_accessor :results
    attr_reader :rolls

    def initialize(count, sides: 6)
      @dice = Array.new(count) { Die.new(sides) }
    end

    def highest(count)
      @rolls = @dice.map(&:roll)
      self.results = @rolls.max(count)
      self
    end

    def total
      results.sum
    end

    def to_s
      "#{@dice.size}d#{@dice.first.sides}: rolled #{rolls} => kept #{results}"
    end

  end

  class Die

    attr_reader :sides

    def initialize(sides)
      self.sides = sides
    end

    def roll
      rand(1..sides)
    end

    def to_s
      "d#{sides}"
    end

    private

    attr_writer :sides

  end

end

class DndCharacter

  ATTRS = ATTRIBUTES = %i[
    strength
    dexterity
    constitution
    intelligence
    wisdom
    charisma
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
    @hitpoints ||= 10 + self.class.modifier(constitution)
  end

end
