defmodule ReshapeWeb.VerbView do
  use ReshapeWeb, :view
  alias ReshapeWeb.VerbView

  def render("index.json", %{dataset: dataset}) do
    dataset
  end

  def render("domain.json", %{domain: domain}) do
    %{id: domain.id,
      name: domain.name,
      description: domain.description,
      stub: domain.stub}
  end

  def render("stub.json", %{verb: verb}) do
    verb
  end
end
