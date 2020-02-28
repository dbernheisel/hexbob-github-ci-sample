defmodule AlpineTestTest do
  use ExUnit.Case
  doctest AlpineTest

  test "greets the world" do
    assert AlpineTest.hello() == :world
  end
end
