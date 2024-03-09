defmodule DynamicProgrammingInElixirTest do
  use ExUnit.Case
  doctest DynamicProgrammingInElixir

  test "calculates the min correctly" do
    assert DynamicProgrammingInElixir.my_min([{:ok, [], 3}, {:ok, [], 2}, {:ok, [], 1}]) ==
             {:ok, [], 1}
  end

  test "calculates the lowest cost path correctly" do
    g = :digraph.new()
    source = :digraph.add_vertex(g, :source)
    sink = :digraph.add_vertex(g, :sink)
    v1 = :digraph.add_vertex(g, :v1)
    v2 = :digraph.add_vertex(g, :v2)
    v3 = :digraph.add_vertex(g, :v3)
    _e1 = :digraph.add_edge(g, source, v1, DynamicProgrammingInElixir.make_cost_fn(1))
    _e2 = :digraph.add_edge(g, source, v2, DynamicProgrammingInElixir.make_cost_fn(2))
    _e3 = :digraph.add_edge(g, v1, sink, DynamicProgrammingInElixir.make_cost_fn(3))
    _e4 = :digraph.add_edge(g, v2, sink, DynamicProgrammingInElixir.make_cost_fn(4))
    _e5 = :digraph.add_edge(g, v3, sink, DynamicProgrammingInElixir.make_cost_fn(1))

    assert DynamicProgrammingInElixir.lowest_cost_path(g, source, sink) ==
             {:ok, [source, v1, sink], 4}
  end
end
