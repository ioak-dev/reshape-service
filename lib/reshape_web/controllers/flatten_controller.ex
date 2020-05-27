defmodule ReshapeWeb.FlattenController do
    use ReshapeWeb, :controller

    alias Reshape.Flatten
    alias Reshape.FlattenTraditional
  
    action_fallback ReshapeWeb.FallbackController
  
    def flatten(conn, payload) do

      data = payload["data"]
      meta = 
        %{
          "empty_array" => nil,
          "empty_object" => nil,
          "root_node" => "root"
        }
        |> Map.merge(if payload["meta"] == nil, do: %{}, else: payload["meta"])

      dataset = Flatten.run(data, meta)
      render(conn, "index.json", dataset: dataset)
    end

    def flatten_from_file(conn, payload) do

      # data = payload["data"]
      {:ok, file_content} = payload["attachment"].path |> File.read
      data = file_content |> Jason.decode!
      meta = 
        %{
          "empty_array" => nil,
          "empty_object" => nil,
          "root_node" => "root"
        }
        |> Map.merge(if payload["meta"] == nil, do: %{}, else: payload["meta"])

      dataset = Flatten.run(data, meta)
      render(conn, "index.json", dataset: dataset)
    end
  
    def flatten_traditional(conn, payload) do

      data = payload["data"]
      meta = 
        %{
          "empty_array" => nil,
          "empty_object" => nil,
          "root_node" => "root"
        }
        |> Map.merge(if payload["meta"] == nil, do: %{}, else: payload["meta"])

      dataset = FlattenTraditional.run(data, meta)
      render(conn, "index.json", dataset: dataset)
    end

    def flatten_traditional_from_file(conn, payload) do

      # data = payload["data"]
      {:ok, file_content} = payload["attachment"].path |> File.read
      data = file_content |> Jason.decode!
      meta = 
        %{
          "empty_array" => nil,
          "empty_object" => nil,
          "root_node" => "root"
        }
        |> Map.merge(if payload["meta"] == nil, do: %{}, else: payload["meta"])

      dataset = FlattenTraditional.run(data, meta)
      render(conn, "index.json", dataset: dataset)
    end
end
  