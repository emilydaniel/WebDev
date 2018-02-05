defmodule CalcTest do
  use ExUnit.Case
  doctest Calc

    #simple parsing
    test "simple addition" do
        assert Calc.eval("2 + 3") == 5
    end

    test "simple multiplication" do
        assert Calc.eval("3 * 4") == 12
    end

    test "simple division" do
        assert Calc.eval("12 / 3") == 4
    end

    test "simple subtraction" do
        assert Calc.eval("4 - 2") == 2
    end

    #no space parsing
    test "no space addition" do
        assert Calc.eval("3+2") == 5
    end

    test "no space multiplication" do
        assert Calc.eval("4*1") == 4
    end

    test "no space division" do
        assert Calc.eval("8/2") == 4
    end

    test "no space subtraction" do
        assert Calc.eval("6-7") == -1
    end

    #order of operations
    test "simple order of ops" do
        assert Calc.eval("3 * 2 + 3") == 9
    end

    test "simple order of ops 2" do
        assert Calc.eval("4 - 2 / 2") == 3
    end

    test "simple order of ops 3" do
        assert Calc.eval("3 + 4 / 2") == 5
    end

    test "med order of ops" do
        assert Calc.eval("3 * 2 - 6 + 2") == 2
    end
    
    test "med order of ops 2" do
        assert Calc.eval("3 / 3 + 5 * 2") == 11
    end

    test "hard order of ops" do
        assert Calc.eval("3 / 4 * 2 - 2") == -0.5
    end

    test "hard order of ops 2" do
        assert Calc.eval("3 - 2 + 2 * 2 + 4") == 9
    end

    test "hard order of ops 3" do
        assert Calc.eval("5 * 3 / 2 + 4 * 2 * 3 - 5") == 26.5
    end
    
    # simple parens
    test "simple parens" do
        assert Calc.eval("3 + (4 - 2)") == 5
    end

    test "simple parens 2" do
        assert Calc.eval("(2 * 2) - 2") == 2
    end

    #multiple parens
    test "multiple parens" do
        assert Calc.eval("(2 - 5) + 4 * (3 - 2)") == 1
    end

    test "multiple parens 2" do
        assert Calc.eval("3 * (2 + 1) - 5 + (4 / 2) - 2") == 4
    end

    #nested parens
    test "nested parens" do
        assert Calc.eval("3 * (3 * (2 - 3))") == -9
    end

    test "nested parens 2" do
        assert Calc.eval("(4 - 2 + (3 - 4 * 3) + 6) * 8") == -8
    end
end
