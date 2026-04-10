module Roller

  class Cup

    private

    attr_accessor :dice
    attr_writer :results, :rolls

    def initialize(count, sides: 6)
      self.dice    = Array.new(count) { Die.new(sides) }
      self.rolls   = []
      self.results = []
    end

    def state
      rolls.empty? ? 'ready to roll' :
                     'rolled %<rolls>p => kept %<results>p' % {rolls:, results:}
    end

    def die
      '%<size>id%<first>i: ' % {size: dice.size, first: dice.first.sides}
    end

    public

    attr_reader :results, :rolls

    def roll
      self.rolls   = dice.map(&:roll)
      self.results = rolls
      self
    end

    def highest(count)
      self.results = rolls.max(count)
      self
    end

    def total
      results.sum
    end

    def to_s
      die + state
    end

  end

  class Die

    private

    attr_writer :sides

    def initialize(sides = 6)
      self.sides = sides
    end

    public

    attr_reader :sides

    def roll
      rand(1..sides)
    end

    def to_s
      'd%<sides>i' % {sides:}
    end

  end

end

class DndCharacter

  BASE_SCORE = 10

  BASE_HITPOINTS = 10

  CHARACTER_SHEET = <<~SHEET
    --- D&D Character Sheet ---
    HP: %<hitpoints>i (CON Mod: %<modifier>+i)
    Stats: STR %<strength>2i | DEX %<dexterity>2i | CON %<constitution>2i
           INT %<intelligence>2i | WIS %<wisdom>2i | CHA %<charisma>2i
  SHEET

  ATTRS = ATTRIBUTES = %i[
    strength dexterity constitution intelligence wisdom charisma
  ]

  private_constant :ATTRS

  def self.modifier(score)
    (score - BASE_SCORE)/2
  end

  private

  def initialize
    ATTRS.each do |attribute|
      send("#{attribute}=", roll_ability)
    end

    self.modifier = self.class.modifier(constitution)
    self.hitpoints = BASE_HITPOINTS + modifier
  end

  attr_writer *ATTRS,
              :hitpoints,
              :modifier

  def roll_ability
    Roller::Cup.new(4).roll.highest(3).total
  end

  public

  attr_reader *ATTRS,
              :hitpoints,
              :modifier

  def to_s
    CHARACTER_SHEET % {
          modifier:,
         hitpoints:,
          strength:,
         dexterity:,
      constitution:,
      intelligence:,
            wisdom:,
          charisma:
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
  puts

  puts "Keeping highest 3: #{my_cup.highest(3)}"
  puts "Total of highest 3: #{my_cup.total}"
  puts

  puts '## Demonstrating the DndCharacter Class'
  my_character = DndCharacter.new
  puts 'Generated a new character:'
  puts my_character
end
