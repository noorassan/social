defmodule Social.NotificationController do
  use Social.Web, :controller
  alias Social.Notification

  def delete(conn, %{"id" => id}) do
    Repo.get(Notification, id)
    |> Repo.delete

    conn
    |> redirect(to: "/")
  end
end
