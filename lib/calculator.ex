defmodule Calculator do
  alias Calculator.Boundary
  # This function returns a pid
  def start(initial_state) do
    Boundary.start(initial_state)
  end

  #These functions are to retrives the async fn
  def add(calculator, n), do: send(calculator, {:add, n})
  def subtract(calculator, n), do: send(calculator, {:subtract, n})
  def multiply(calculator, n), do: send(calculator, {:multiply, n})
  def divide(calculator, n), do: send(calculator, {:divide, n})
  def neg(calculator), do: send(calculator, :negate)

  def custom(calculator, f, n), do: send(calculator, {:custom, f, n})

  def clear(calculator), do: send(calculator, :clear)

  #Outline of the sync function to retrieve state
  def state(calculator) do
    send(calculator, {:state, self()})
    receive do
      {:state, state} ->
        state
    after
      5000 ->
        {:error, :timeout}
    end
  end

end
