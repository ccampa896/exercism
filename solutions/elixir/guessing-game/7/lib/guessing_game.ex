defmodule GuessingGame do
  # Define o cabeçalho da função com o valor padrão
  def compare(secret_number, guess \\ nil)
  
  # Cláusula para quando 'guess' for um átomo
  def compare(_secret_number, guess) when is_atom(guess) do
    "Make a guess"
  end

  # Cláusula para quando o palpite estiver correto
  def compare(secret_number, guess) when secret_number === guess do
    "Correct"
  end

  # Cláusula para quando o palpite estiver próximo do número secreto
  def compare(secret_number, guess) when (secret_number === guess + 1) or (secret_number === guess - 1) do
    "So close"
  end

  # Cláusula para quando o palpite for maior que o número secreto
  def compare(secret_number, guess) when secret_number < guess do
    "Too high"
  end

  # Cláusula para quando o palpite for menor que o número secreto
  def compare(secret_number, guess) when secret_number > guess do
    "Too low"
  end

  # Caso nenhuma das condições anteriores seja satisfeita
  def compare(_secret_number, _guess) do
    "Make a guess"
  end
end
