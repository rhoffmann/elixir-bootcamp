defmodule DiscussWeb.TopicController do
  use DiscussWeb, :controller

  alias Discuss.{Topic, Repo}

  def new(conn, _params) do
    changeset = Topic.changeset(%Topic{}, %{})

    render conn, "new.html", [changeset: changeset]
  end

  def create(conn, %{"topic" => topic}) do
    changeset = Topic.changeset(%Topic{}, topic)

    case Repo.insert(changeset) do
      {:ok, _topic} ->
        conn
        |> put_flash(:info, "Topic created successfully.")
        |> redirect(to: topic_path(conn, :list))
      {:error, changeset} ->
        render conn, "new.html", changeset: changeset
    end
  end

  def list(conn, _params) do
    topics = Repo.all(Topic)
    render conn, "list.html", topics: topics
  end
end
