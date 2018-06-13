defmodule Cards do
  def create_deck do
    values = ["Ass", "Zwei", "Drei", "Vier", "Fünf", "Sechs", "Sieben", "Acht", "Neun", "Zehn", "Bube", "Dame", "König"]
    suits = ["Kreuz", "Pik", "Herz", "Karo"]

    for suit <- suits do
      for value <- values do
        "#{suit} #{value}"
      end
    end
  end

  def shuffle(deck) do
    Enum.shuffle(deck)
  end

  def contains?(deck, hand) do
    Enum.member?(deck, hand)
  end
end
