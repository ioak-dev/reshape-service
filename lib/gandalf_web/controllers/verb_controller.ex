defmodule GandalfWeb.VerbController do
    use GandalfWeb, :controller

    alias Gandalf.VerbGet
  
    action_fallback GandalfWeb.FallbackController
  
    def get(conn, %{"id" => id}) do
      dataset = VerbGet.run(id)
      render(conn, "index.json", dataset: dataset)
    end
end
  