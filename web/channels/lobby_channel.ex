defmodule HelloPhoenix.LobbyChannel do
  use HelloPhoenix.Web, :channel
  require Logger

  def join("lobby" <> _id, payload, socket) do
    if authorized?(payload) do
      {:ok, socket}
    else
      {:error, %{reason: "unauthorized"}}
    end
  end

  # Channels can be used in a request/response fashion
  # by sending replies to requests from the client
  def handle_in("ping", payload, socket) do
    {:reply, {:ok, payload}, socket}
  end

  # It is also common to receive messages from the client and
  # broadcast to everyone in the current topic (lobby:lobby).
  def handle_in("shout", payload, socket) do

    broadcast socket, "shout", %{lol: "lol"}
    {:noreply, socket}
  end

  intercept ["shout"]
  def handle_out("shout", payload, socket) do
    IO.inspect payload
    IO.inspect socket
    IO.puts "6666666666666666"
    push socket, "shout", payload
    {:noreply, socket}
  end

  # Add authorization logic here as required.
  defp authorized?(_payload) do
    true
  end
end
