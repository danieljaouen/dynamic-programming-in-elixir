defmodule DynamicProgrammingInElixir do
  @moduledoc """
  A short example of dynamic programming in Elixir.
  """

  @doc """
  Our function to make cost functions.
  """
  def make_cost_fn(cost) do
    fn -> cost end
  end

  @doc """
  Our specialized min function.

  ## Examples

      iex> DynamicProgrammingInElixir.my_min([{:ok, [], 1}, {:ok, [], 2}])
      {:ok, [], 1}

  """
  def my_min(lst) do
    if !Enum.empty?(lst) do
      Enum.reduce(lst, hd(lst), fn x, acc -> if elem(x, 2) < elem(acc, 2), do: x, else: acc end)
    else
      {:error, "Empty list"}
    end
  end

  defp calculate_current_path(g, source, edge) do
    {_e, v1, _v2, cost_fn} = :digraph.edge(g, edge)

    case lowest_cost_path_helper(g, source, v1) do
      {:ok, path, cost} ->
        {:ok, [v1 | path], cost + cost_fn.()}

      {:error, msg} ->
        {:error, msg}
    end
  end

  defp lowest_cost_path_helper(g, source, sink) do
    if source == sink do
      {:ok, [], 0}
    else
      in_edges = :digraph.in_edges(g, sink)

      if in_edges == [] do
        {:error, "No path from source to sink"}
      else
        in_edges
        |> Enum.map(fn edge -> calculate_current_path(g, source, edge) end)
        |> Enum.filter(fn x -> elem(x, 0) != :error end)
        |> my_min()
      end
    end
  end

  @doc """
  Our lowest cost path function.
  """
  def lowest_cost_path(g, source, sink) do
    if !:digraph_utils.is_acyclic(g) do
      {:error, "Graph is not acyclic"}
    else
      case lowest_cost_path_helper(g, source, sink) do
        {:ok, path, cost} ->
          {:ok, Enum.reverse(path) ++ [sink], cost}

        {:error, _msg} ->
          {:error, "No path from source to sink"}
      end
    end
  end
end
