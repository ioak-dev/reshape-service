defmodule ReshapeWeb.FlattenView do
  use ReshapeWeb, :view
  alias ReshapeWeb.FlattenView

  def render("index.json", %{dataset: dataset}) do
    dataset
  end
end
