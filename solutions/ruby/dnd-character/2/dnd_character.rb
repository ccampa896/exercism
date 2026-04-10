class DndCharacter

  ABILITY_SCORE_ATTRIBUTES = %i[strength dexterity constitution intelligence wisdom charisma].freeze
  BASE_HITPOINTS = 10
  DICE_COUNT = 4
  DICE_SIDES = 6
  KEPT_DICE = 3

  attr_reader(*ABILITY_SCORE_ATTRIBUTES)

  def self.modifier(constitution)
    ((constitution - 10) / 2.0).floor
  end

  def initialize
    ABILITY_SCORE_ATTRIBUTES.each do |attribute|
      instance_variable_set("@#{attribute}", roll_dice)
    end
  end

  def hitpoints
    BASE_HITPOINTS + self.class.modifier(constitution)
  end

  private

  def roll_dice
    Array.new(DICE_COUNT) { rand(1..DICE_SIDES) }
      .max(KEPT_DICE)
      .sum
  end

end