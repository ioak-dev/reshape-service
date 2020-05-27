defmodule ReshapeWeb.ConvertcsvView do
  use ReshapeWeb, :view
  alias ReshapeWeb.ConvertcsvView

  def render("index.json", %{dataset: dataset}) do
    dataset
  end
end
