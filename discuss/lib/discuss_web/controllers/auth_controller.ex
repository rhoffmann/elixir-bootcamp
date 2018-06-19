defmodule DiscussWeb.AuthController do
  use DiscussWeb, :controller

  alias Discuss.{User, Repo}

  plug Ueberauth


  defp insert_or_update_user(changeset) do
    case Repo.get_by(User, email: changeset.changes.email) do
      user ->
        {:ok, user}
      nil ->
        Repo.insert(changeset)
    end
  end


  defp signin(conn, changeset) do
    case insert_or_update_user(changeset) do
      {:ok, user} ->
        conn
        |> put_flash(:info, "Welcome #{user.email}")
        |> put_session(:user_id, user.id)
        |> redirect(to: topic_path(conn, :index))
      {:error, _reason} ->
        conn
        |> put_flash(:error, "Error signing in")
        |> redirect(to: topic_path(conn, :index))
    end
  end


  # defp logout(conn, changeset) do

  # end


  def callback(%{assigns: %{ueberauth_auth: auth}} = conn, _params) do
    user_params = %{
      token: auth.credentials.token,
      email: auth.info.email,
      provider: to_string(auth.provider),
      user_name: auth.info.nickname,
      full_name: auth.info.name,
      image_url: auth.info.image
    }

    changeset = User.changeset(%User{}, user_params)

    signin(conn, changeset)
  end
end
