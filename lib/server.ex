defmodule Calculator.Server do
    use GenServer
    alias Calculator.Core

# client side/API
    def start_link(initial) when is_integer(initial) do
        GenServer.start_link(__MODULE__, initial)
    end

    def add(pid, number), do: GenServer.cast(pid, {:add, number})
    def subtract(pid, number), do: GenServer.cast(pid, {:subtract, number})
    def multiply(pid, number), do: GenServer.cast(pid, {:multiply, number})
    def divide(pid, number), do: GenServer.cast(pid, {:divide, number})
    def clear(pid), do: GenServer.cast(pid, :clear)
    def neg(pid), do: GenServer.cast(pid, :negate)

    def state(pid) do
        GenServer.call(pid, :state)
    end
    
#callbacks
    def init(number) do
        inc_initial()
        {:ok, number}
    end

    def handle_cast({:add, number}, state) do
        {:noreply, Core.add(state, number)}
    end

    def handle_cast({:subtract, number}, state)do
        {:noreply, Core.subtract(state, number)}
    end

    def handle_cast({:multiply, number}, state) do
        {:noreply, Core.multiply(state, number)}
    end

    def handle_cast({:divide, number}, state) do
        {:noreply, Core.divide(state, number)}
    end

    def handle_cast(:negate, state) do
        {:noreply, Core.neg(state)}
    end

    def handle_cast(:clear, _state) do
        {:noreply, 0}
    end

    def handle_call(:state, _from, state) do
        {:reply, state, state}
    end

    def handle_info(:inc, state) do
        state = Core.inc(state)
        inc_intial()
        {:noreply, state}
    end

    defp  inc_initial do
        #In 1 min
        Process.send_after(self(), :inc, 1 * 60 * 1000)
    end
end