module Roller

  class Cup
  
    attr_reader :results, :rolls

    def initialize(count, sides: 6)
      self.dice = Array.new(count) { Die.new(sides) }
      self.rolls = []
      self.results = []
    end

    def roll
      self.rolls = dice.map(&:roll)
      self.results = rolls 
      self
    end

    def highest(count)
      roll
      self.results = rolls.max(count)
      self
    end

    def total
      results.sum
    end

    def to_s
      if rolls.empty?
        "%dd%d: ready to roll" % [dice.size, dice.first.sides]
      else
        "%dd%d: rolled %p => kept %p" % [dice.size, dice.first.sides, rolls, results]
      end
    end

    private

    attr_accessor :dice
    attr_writer :results, :rolls

  end

  class Die

    attr_reader :sides

    def initialize(sides = 6)
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

  BASE_SCORE = 10
  BASE_HITPOINTS = 10

  ATTRS = ATTRIBUTES = %i[
    strength dexterity constitution intelligence wisdom charisma
  ]

  private_constant :ATTRS

  def self.modifier(score)
    (score - BASE_SCORE) / 2
  end

  private

  def initialize
    ATTRS.each do |attribute|
      send("#{attribute}=", roll_ability)
    end

    self.hitpoints = BASE_HITPOINTS + self.class.modifier(constitution)
  end

  attr_writer *ATTRS, :hitpoints

  def roll_ability
    Roller::Cup.new(4).highest(3).total
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

if $PROGRAM_NAME == __FILE__
  puts '## Demonstrating the Die Class'
  my_die = Roller::Die.new
  puts "Created a die: #{my_die}"
  puts "Rolling the die: #{my_die.roll}"
  puts

  puts '## Demonstrating the Cup Class'
  my_cup = Roller::Cup.new(4)
  puts "Created a cup: #{my_cup}"
  puts "Rolling the cup: #{my_cup.roll}"
  puts "Total of all dice: #{my_cup.total}"

  puts "\nRolling again and keeping highest 3: #{my_cup.highest(3)}"
  puts "Total of highest 3: #{my_cup.total}"
  puts

  puts '## Demonstrating the DndCharacter Class'
  my_character = DndCharacter.new
  puts "Generated a new character:\n"
  puts my_character
end
