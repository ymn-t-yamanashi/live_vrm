defmodule ThreeWeb.CgLive.Index do
  use ThreeWeb, :live_view
  import ThreeWeb.Cg.CgHelper

  def mount(_params, _session, socket) do
    Process.send_after(self(), :update, 500)

    socket =
      socket
      |> assign(data: initialization_character_data())
      |> load_model("test", "images/test.vrm")


    {:ok, main(socket)}
  end

  # @impl true
  def handle_info(:update, socket) do
    Process.send_after(self(), :update, 12)
    {:noreply, main(socket)}
  end

  def handle_event("load_model", %{"name" => "test", "status" => "completion"}, socket) do
    socket =
      socket
      |> position("test", 0, -1.4, 4.5)
      |> rotation("test", 0, 3.1, 0)
      |> rotation_bone("test", "J_Bip_R_UpperArm", -1.0, 1.2, 0.5)
      |> rotation_bone("test", "J_Bip_L_UpperArm", -1.0, -1.2, -0.5)

    {:noreply, socket}
  end


  defp initialization_character_data() do
    0
  end

  defp main(socket) do
    character_data = update(socket.assigns.data)

    socket
    #|> rotation("test", 0, character_data / 4, 0)
    |> assign(data: character_data)
  end

  defp update(character_data) do
    character_data + 0.05
  end

end
