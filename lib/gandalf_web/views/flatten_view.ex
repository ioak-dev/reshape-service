defmodule GandalfWeb.FlattenView do
  use GandalfWeb, :view
  alias GandalfWeb.FlattenView

  def render("index.json", %{dataset: dataset}) do
    dataset
  end
end
