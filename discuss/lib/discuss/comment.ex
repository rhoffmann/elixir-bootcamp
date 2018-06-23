defmodule Discuss.Comment do
  use Discuss, :model

  schema "comments" do
    field :content, :string

    belongs_to(:user, Discuss.User)
    belongs_to(:topic, Discuss.Topic)

    timestamps()
  end

  def changeset(struct, attrs \\ %{}) do
    struct
    |> cast(attrs, [:content])
    |> validate_required([:content])
  end

end
