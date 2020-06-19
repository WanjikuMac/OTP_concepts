defmodule Calculator.BoundaryPnp do
    def start(initial_list) do
        GenServer.start_link()
    end

    def init(initial_list) do
        {:ok, initial_list}
    end

    def handle_cast({:push, element}, state) do
        new_state = Pnp.inc_list(state, element)
        {:noreply, new_state}
    end

    def handle_call(:state, _from, state) do
        {:reply, state, new_state}
    end
end
