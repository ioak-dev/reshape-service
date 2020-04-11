defmodule GandalfWeb.FlattenController do
    use GandalfWeb, :controller

    alias Gandalf.Flatten
  
    action_fallback GandalfWeb.FallbackController
  
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
end
  