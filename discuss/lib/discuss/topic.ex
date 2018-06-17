defmodule Discuss.Topic do
  use Ecto.Schema
  import Ecto.Changeset


  schema "topics" do
    field :title, :string

    timestamps()
  end

  @doc false
  def changeset(struct, attrs \\ %{}) do
    struct
    |> cast(attrs, [:title])
    |> validate_required([:title])
    |> validate_length(:title, min: 2)
  end
end