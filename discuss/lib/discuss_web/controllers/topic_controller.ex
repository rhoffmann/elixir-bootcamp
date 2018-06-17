defmodule DiscussWeb.TopicController do
  use DiscussWeb, :controller

  alias Discuss.Topic

  def new(conn, _params) do
    changeset = Topic.changeset(%Topic{}, %{})

    render conn, "new.html", [changeset: changeset]
  end

  def create(conn, %{"topic" => topic}) do
    IO.puts "***"
    inspect topic
    IO.puts "***"
    changeset = Topic.changeset(%Topic{}, topic)


    # case changeset do
    #   %{ valid? => true } ->
    # end
    # inspect changeset
    # if changeset.valid?

  end
end
