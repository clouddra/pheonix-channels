require IEx
defmodule HelloPhoenix.PageController do
  use HelloPhoenix.Web, :controller

  def index(conn = %Plug.Conn{private: %{phoenix_format: "json"}}, _params) do
    HelloPhoenix.Endpoint.broadcast!("lobby:1", "shout", %{something: "1"})
    HelloPhoenix.Endpoint.broadcast!("lobby:0", "shout", %{something: "0"})
    json(conn, %{lol: "lol"})
  end

  def index(conn = %Plug.Conn{private: %{phoenix_format: "html"}}, _params) do
      render conn, "index.html"
    end
end
