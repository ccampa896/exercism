defmodule BoutiqueInventory do
  def sort_by_price(inventory) do
    Enum.sort_by(inventory, &(&1.price))
  end

  def with_missing_price(inventory) do
    Enum.filter(inventory, &(&1.price == nil))
  end

  def update_names(inventory, old_word, new_word) do
    Enum.map(inventory, fn item ->
      updated_name = String.replace(item.name, old_word, new_word)
      %{item | name: updated_name}
    end)
  end
  
  def increase_quantity(item, count) do
    # Adiciona `count` para cada tamanho existente ou inicia o mapa se estiver vazio
    updated_quantity =
      item.quantity_by_size
      |> Enum.map(fn {size, q} -> {size, q + count} end)
      |> Enum.into(%{})

    %{item | quantity_by_size: updated_quantity}
  end

  def total_quantity(item) do
    Enum.reduce(item.quantity_by_size, 0, fn {_, q}, acc -> q + acc end)
  end
end
