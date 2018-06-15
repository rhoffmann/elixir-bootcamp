defmodule Identicon do
  def main(input) do
    input
    |> hash_input
    |> get_color
    |> create_grid
  end

  def hash_input(input) do
    hex = :crypto.hash(:md5, input)
    |> :binary.bin_to_list

    %Identicon.Image{ hex: hex }
  end

  def get_color(%Identicon.Image{ hex: [r, g, b | _tail ]} = image) do
    # %Identicon.Image{ image | color: { r, g, b } }
    %Identicon.Image{ image | color: %{ r: r, g: g, b: b } }
  end

  def mirror_row(row) do
    [first, second, _tail] = row
    row ++ [second, first]
  end

  def create_grid(%Identicon.Image{ hex: hex }) do
    hex
    |> Enum.chunk(3)
    |> Enum.map(&mirror_row/1)
  end
end
