defmodule Discuss.User do
  use Discuss, :model

  schema "users" do
    field :email, :string
    field :provider, :string
    field :token, :string
    field :user_name, :string
    field :full_name, :string
    field :image_url, :string

    has_many(:topics, Discuss.Topic)

    timestamps()
  end

  def changeset(struct, attrs \\ %{}) do
    struct
    |> cast(attrs, [:email, :provider, :token, :user_name, :full_name, :image_url])
    |> validate_required([:email, :provider, :token])
  end
end
