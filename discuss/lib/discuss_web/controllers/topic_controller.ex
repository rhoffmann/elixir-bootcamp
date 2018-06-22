defmodule DiscussWeb.TopicController do
  use DiscussWeb, :controller

  alias Discuss.{Topic, Repo}

  plug DiscussWeb.Plugs.RequireAuth when action in [
    :new, :create, :update, :edit, :delete
  ]

  plug :check_topic_owner when action in [
    :edit, :update, :delete
  ]

  def index(conn, _params) do
    topics = Repo.all(Topic)
    render conn, "index.html", topics: topics
  end


  def new(conn, _params) do
    changeset = Topic.changeset(%Topic{}, %{})

    render conn, "new.html", [changeset: changeset]
  end


  def create(conn, %{"topic" => topic}) do

    changeset = conn.assigns[:user]
      |> Ecto.build_assoc(:topics)
      |> Topic.changeset(topic)

    case Repo.insert(changeset) do
      {:ok, _topic} ->
        conn
        |> put_flash(:info, "Topic created successfully.")
        |> redirect(to: topic_path(conn, :index))
      {:error, changeset} ->
        conn
        |> put_flash(:error, "Error creating Topic")
        |> render("new.html", changeset: changeset)
    end
  end


  def edit(conn, %{"id" => topic_id}) do
    topic = Repo.get(Topic, topic_id)
    changeset = Topic.changeset(topic)

    render conn, "edit.html", changeset: changeset, topic: topic
  end


  def update(conn, %{"id" => topic_id, "topic" => topic}) do
    old_topic = Repo.get(Topic, topic_id)
    changeset = Topic.changeset(old_topic, topic)

    case Repo.update(changeset) do
      {:ok, topic} ->
        conn
        |> put_flash(:info, "Topic #{topic.id} updated successfully.")
        |> redirect(to: topic_path(conn, :index))
      {:error, changeset} ->
        conn
        |> put_flash(:error, "Error updating Topic")
        |> render("edit.html", changeset: changeset, topic: old_topic)
    end
  end


  def delete(conn, %{"id" => topic_id}) do
    Repo.get!(Topic, topic_id) |> Repo.delete!

    conn
    |> put_flash(:info, "Topic deleted")
    |> redirect(to: topic_path(conn, :index))
  end

  def has_user?(conn) do
    Map.has_key?(conn.assigns, :user)
  end

  defp check_topic_owner(conn, _params) do
    %{params: %{"id" => topic_id }} = conn
    if has_user?(conn) && Repo.get(Topic, topic_id).user_id == conn.assigns.user.id do
      conn
    else
      conn
      |> put_flash(:error, "You cannot edit this topic")
      |> redirect(to: topic_path(conn, :index))
      |> halt()
    end
  end
end
