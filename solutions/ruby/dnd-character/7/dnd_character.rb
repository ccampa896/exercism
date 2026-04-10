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
      "%dd%d: rolled %p => kept %p" % [
        dice.size,
        dice.first.sides,
        rolls,
        results
      ]
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
      "d%d" % sides
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
    template = <<~SHEET
      --- D&D Character Sheet ---
      HP: %<hp>d (CON Mod: %<mod>+d)
      Stats: STR %<str>2d | DEX %<dex>2d | CON %<con>2d
             INT %<int>2d | WIS %<wis>2d | CHA %<cha>2d
    SHEET

    template % {
      hp:  hitpoints,
      mod: self.class.modifier(constitution),
      str: strength,
      dex: dexterity,
      con: constitution,
      int: intelligence,
      wis: wisdom,
      cha: charisma
    }
  end

end
