defmodule ReshapeWeb.ConvertcsvController do
    use ReshapeWeb, :controller

    alias Reshape.Convertcsv
  
    action_fallback ReshapeWeb.FallbackController
  
    def to_csv(conn, payload) do

      data = payload["data"]
      meta = 
        %{
          "empty_array" => nil,
          "empty_object" => nil,
          "root_node" => "root"
        }
        |> Map.merge(if payload["meta"] == nil, do: %{}, else: payload["meta"])

      response = Convertcsv.run(data, meta)
      # conn
      # |> send_download({:binary, response}, filename: "output.csv")
        # render(conn,send_download(conn, {:binary, dataset}, filename: "output.csv"))
      render(conn, "index.json", dataset: response)
    end

    def to_csv_from_file(conn, payload) do

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

      dataset = Convertcsv.run(data, meta)
      render(conn, "index.json", dataset: dataset)
    end
end
  