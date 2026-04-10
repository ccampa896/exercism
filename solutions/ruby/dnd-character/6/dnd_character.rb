module Roller

  class Cup
    attr_reader :results, :rolls

    def initialize(count, sides: 6)
      self.dice = Array.new(count) { Die.new(sides) }
    end

    def highest(count)
      self.rolls = dice.map(&:roll)
      self.results = rolls.max(count)
      self
    end

    def total
      results.sum
    end

    def to_s
      "#{dice.size}d#{dice.first.sides}: rolled #{rolls} => kept #{results}"
    end

    private

    attr_accessor :dice
    attr_writer :results, :rolls
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
    strength dexterity constitution intelligence wisdom charisma
  ]
  private_constant :ATTRS

  def self.modifier(score)
    (score - 10) / 2
  end

  private

  def initialize
    ATTRS.each do |attribute|
      send("#{attribute}=", roll_ability)
    end

    self.hitpoints = 10 + self.class.modifier(constitution)
  end

  attr_writer *ATTRS, :hitpoints

  def roll_ability
    Roller::Cup.new(4, sides: 6).highest(3).total
  end

  public

  attr_reader *ATTRS, :hitpoints

  def to_s
    <<~SHEET
      --- D&D Character Sheet ---
      HP: #{hitpoints} (CON Mod: #{self.class.modifier(constitution)})
      Stats: STR #{strength} | DEX #{dexterity} | CON #{constitution}
             INT #{intelligence} | WIS #{wisdom} | CHA #{charisma}
    SHEET
  end
end
