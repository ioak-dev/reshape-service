defmodule Reshape.FlattenTraditional do
    import Ecto

    def run([head | tail], meta) do
        IO.inspect(head)
        if Enum.count(tail) != 0 do
            [run(head, meta)] ++ run(tail, meta)
        else
            [run(head, meta)]
        end
    end

    def run(data, meta) do
        decompose(%{}, data, "", 0)
    end

    defp decompose(previous_result, node, name, index) when is_binary(node) do
        previous_result |> Map.put(name, node)
    end

    defp decompose(previous_result, node, name, index) when node == %{} do
        previous_result |> Map.put(name, "")
    end

    defp decompose(previous_result, node, name, index) when node == [] do
        previous_result |> Map.put(name, "")
    end

    defp decompose(previous_result, node, name, index) when is_map(node) do
        first_key = 
            node
            |> Map.keys
            |> List.first

        tail_node = 
            Map.delete(node, first_key)
        initial_map = 
            previous_result 
            |> Map.merge(decompose(previous_result, node[first_key], construct_key(name, first_key), 0))
        if map_size(tail_node) > 0 do
            initial_map
            |> Map.merge(decompose(initial_map, tail_node, construct_key(name), 0))
        else
            initial_map
        end
    end

    defp decompose(previous_result, [head | tail], name, index) do
        initial_map = 
            previous_result 
            |> Map.merge(decompose(previous_result, head, construct_key(name, index+1), 0))
        if Enum.count(tail) != 0 do
            initial_map
            |> Map.merge(decompose(initial_map, tail, construct_key(name), index+1))
        else
            initial_map
        end
    end

    defp decompose(previous_result, node, name, index) when true do
        previous_result |> Map.put(name, node)
    end

    defp merge_map(a, b) do
        cond do
            a != nil && b != nil ->
                Map.merge(a, b)
            a != nil ->
                a
            b != nil ->
                b
            true ->
                %{}
        end
    end

    defp construct_key(key) do
        "#{key}"
    end

    defp construct_key(key, key_extend) when key == "" do
        "#{key_extend}"
    end

    defp construct_key(key, key_extend) when true do
        "#{key}.#{key_extend}"
    end
end