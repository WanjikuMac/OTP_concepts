defmodule CoreTest do
    use ExUnit.Case
    import Calculator.Core
    # when using import you don't have 
    # to mention the module name 
    # e.g add(param1, param2)
    # But with the alias you need
    # To mention the module name 
    # e.g Core.add(param1, param2) 

    test "substracts" do
        assert subtract(10,9) == 1
    end

    test "add" do
        assert add(4,5) == 9
    end

    test "multiplies" do
        assert multiply(2,3) == 6
    end

    test "divide" do
        assert divide(6,3) == 2
    end

    test "fold" do
        assert fold([1,2,3,4], 0, &add/2) == 10
    end
end