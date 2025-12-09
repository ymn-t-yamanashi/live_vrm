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
    Process.send_after(self(), :update, 250)
    {:noreply, main(socket)}
  end

  def handle_event("load_model", %{"name" => "test", "status" => "completion"}, socket) do
    socket =
      socket
      |> position("test", 0, -1.4, 4.5)
      |> position("test", 0, -1.4, 4.5)
      |> rotation("test", 0, 3.1, 0)
      |> rotation_bone("test", "J_Bip_R_UpperArm", -1.0, 1.2, 0.5)
      |> rotation_bone("test", "J_Bip_L_UpperArm", -1.0, -1.2, -0.5)
      |> set_blend_shape("test", "aa", 0.2)
      |> set_blend_shape("test", "blink", 1.0)

    {:noreply, socket}
  end

  defp initialization_character_data() do
    0
  end

  defp main(socket) do
    character_data = update(socket.assigns.data)

    socket
    |> set_blend_shape("test", "aa", character_data)
    |> set_blend_shape("test", "blink", character_data)
    |> assign(data: character_data)
  end

  defp update(1), do: 0
  defp update(0), do: 1
end
