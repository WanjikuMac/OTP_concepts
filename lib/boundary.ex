defmodule Calculator.Boundary do
    alias Calculator.Core
    def listen(state)do
        receive do 
            {:add, number} ->                   #handle cast
                Core.add(state, number)
            {:subtract, number} ->              #handle cast
                Core.subtract(state, number)
            {:multiply, number} ->              #handle cast
                Core.multiply(state, number)
            {:divide, number} ->                #handle cast
                Core.divide(state, number)
            {:custom, f, number} -> 
                Core.fold(state, f, number)
            :clear ->                       
                0
            {:state, pid} ->                    #handle call
                send(pid, {:state, state})
                state
        end
    end

    def run(state) do
        state
        |>listen
        |>run
    end

    def start(initial_state) do                 #init fn
        spawn(fn -> run(initial_state) end)
    end
end