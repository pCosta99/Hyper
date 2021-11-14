defmodule HyperApiWeb.PageController do
  use HyperApiWeb, :controller

  def index(conn, _params) do
    render(conn, "index.html")
  end
end
