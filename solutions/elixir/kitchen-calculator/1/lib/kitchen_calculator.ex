defmodule KitchenCalculator do
  def get_volume(volume_pair) do
    {_, number} = volume_pair
    number
  end

  def to_milliliter({:cup, volume}) do
    {:milliliter, volume * 240}
  end

  def to_milliliter({:fluid_ounce, volume}) do
    {:milliliter, volume * 30}
  end

  def to_milliliter({:teaspoon, volume}) do
    {:milliliter, volume * 5}
  end

  def to_milliliter({:tablespoon, volume}) do
    {:milliliter, volume * 15}
  end

  def to_milliliter({:milliliter, volume}) do
    {:milliliter, volume}
  end

  def from_milliliter(volume_pair, :cup) do
    {:milliliter, volume} = volume_pair
    {:cup, volume / 240}
  end

  def from_milliliter(volume_pair, :fluid_ounce) do
    {:milliliter, volume} = volume_pair
    {:fluid_ounce, volume / 30}
  end

  def from_milliliter(volume_pair, :teaspoon) do
    {:milliliter, volume} = volume_pair
    {:teaspoon, volume / 5}
  end

  def from_milliliter(volume_pair, :tablespoon) do
    {:milliliter, volume} = volume_pair
    {:tablespoon, volume / 15}
  end

  def from_milliliter(volume_pair, :milliliter) do
    {:milliliter, volume} = volume_pair
    {:milliliter, volume}
  end

  def convert(volume_pair, unit) do
    {:milliliter, milliliters} = to_milliliter(volume_pair)
    from_milliliter({:milliliter, milliliters}, unit)
  end

end
