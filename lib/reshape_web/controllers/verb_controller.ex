defmodule ReshapeWeb.VerbController do
    use ReshapeWeb, :controller

    alias Reshape.VerbGet
  
    action_fallback ReshapeWeb.FallbackController
  
    def get(conn, %{"id" => id}) do
      dataset = VerbGet.run(id)
      render(conn, "index.json", dataset: dataset)
    end
end
  