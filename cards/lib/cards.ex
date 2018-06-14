defmodule Cards do
  @moduledoc """
    Provides methods for creating and handling a deck of cards
  """

  @doc """
    Returns a list of strings representing a deck of playing cards
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
    Checks whether a deck contains a specific card

  ## Examples

      iex> deck = Cards.create_deck
      iex> Cards.contains?(deck, "Karo Acht")
      true

  """
  def contains?(deck, hand) do
    Enum.member?(deck, hand)
  end

  @doc """
    Divides a deck into a hand and the remainder of a deck.
    The `hand_size` arguments indicates how many cards
    should be in the hand.

  ## Examples

      iex> deck = Cards.create_deck
      iex> { hand, remaining_deck } = Cards.deal(deck, 2)
      iex> hand
      ["Kreuz Ass", "Kreuz Zwei"]

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
