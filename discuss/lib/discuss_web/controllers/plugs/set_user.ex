defmodule DiscussWeb.Plugs.SetUser do
  import Plug.Conn

  alias Discuss.Repo
  alias Discuss.User

  def init(_params) do
  end

  # params is what is returned from 'init'

  def call(conn, _params) do
    user_id = get_session(conn, :user_id)

    cond do
      user = user_id && Repo.get(User, user_id) ->
        assign(conn, :user, user)
        # conn.assings.user => user struct %User
      true ->
        assign(conn, :user, nil)
    end
  end
end
