defmodule RestaurantPlatform.SessionsFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `RestaurantPlatform.Sessions` context.
  """

  @doc """
  Generate a session.
  """
  def session_fixture(attrs \\ %{}) do
    {:ok, session} =
      attrs
      |> Enum.into(%{
        end_time: ~U[2024-08-26 10:17:00Z],
        session_token: "some session_token",
        start_time: ~U[2024-08-26 10:17:00Z]
      })
      |> RestaurantPlatform.Sessions.create_session()

    session
  end
end
