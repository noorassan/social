defmodule Social.PageController do
  alias Social.Notification
  use Social.Web, :controller

  def index(conn, _params) do
    if conn.assign.current_user do
      notifications = Notification.get_by_user_id(Notification, get_session(conn, :user_id))
      render conn, "index.html", notifications: notifications
    else
      render conn, "index.html"
    end
  end
end
