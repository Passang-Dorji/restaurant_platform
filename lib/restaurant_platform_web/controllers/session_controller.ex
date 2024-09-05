defmodule RestaurantPlatformWeb.SessionController do
  use RestaurantPlatformWeb, :controller

  alias RestaurantPlatform.Sessions
  alias RestaurantPlatform.Sessions.Session

  action_fallback RestaurantPlatformWeb.FallbackController

  def index(conn, _params) do
    sessions = Sessions.list_sessions()
    render(conn, :index, sessions: sessions)
  end

  def create(conn, %{"table_id" => table_id}) do
    case RestaurantPlatform.Sessions.create_session(%{"table_id" => table_id}) do
      {:ok, session} ->
        json(conn, %{session: session})
      {:error, errors} ->
        json(conn, %{error: errors})
    end
  end

  def show(conn, %{"id" => id}) do
    session = Sessions.get_session!(id)
    render(conn, :show, session: session)
  end

  def update(conn, %{"id" => id, "session" => session_params}) do
    session = Sessions.get_session!(id)

    with {:ok, %Session{} = session} <- Sessions.update_session(session, session_params) do
      render(conn, :show, session: session)
    end
  end

  def delete(conn, %{"id" => id}) do
    session = Sessions.get_session!(id)

    with {:ok, %Session{}} <- Sessions.delete_session(session) do
      send_resp(conn, :no_content, "")
    end
  end
end
