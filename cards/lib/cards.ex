defmodule Cards do
  @moduledoc """
  stuff about cards
  """

  @doc """
  creates a deck of cards
  """
  def create_deck do
    values = [
      "Ass",
      "Zwei",
      "Drei",
      "Vier",
      "Fünf",
      "Sechs",
      "Sieben",
      "Acht",
      "Neun",
      "Zehn",
      "Bube",
      "Dame",
      "König"
    ]

    suits = ["Kreuz", "Pik", "Herz", "Karo"]

    for suit <- suits, value <- values do
      "#{suit} #{value}"
    end
  end

  @doc """
  shuffle a deck of cards
  """
  def shuffle(deck) do
    Enum.shuffle(deck)
  end

  @doc """
  check if a deck contains a hand
  """
  def contains?(deck, hand) do
    Enum.member?(deck, hand)
  end

  @doc """
  deal a hand size
  """
  def deal(deck, hand_size) do
    Enum.split(deck, hand_size)
  end

  @doc """
  save a deck to a file
  """
  def save(deck, filename) do
    binary = :erlang.term_to_binary(deck)
    File.write(filename, binary)
  end

  @doc """
  load a deck from a file
  """
  def load(filename) do
    case File.read(filename) do
      {:ok, binary} -> :erlang.binary_to_term(binary)
      {:error, _} -> 'file does not exist'
    end
  end

  @doc """
  create a hand
  """
  def create_hand(hand_size) do
    # piping requires consistent first arguments
    Cards.create_deck
    |> Cards.shuffle
    |> Cards.deal(hand_size)
  end
end
