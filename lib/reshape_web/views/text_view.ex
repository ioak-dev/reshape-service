defmodule ReshapeWeb.TextView do
    use ReshapeWeb, :view
    alias ReshapeWeb.TextView
  
    def render("index.json", %{texts: texts}) do
      %{data: render_many(texts, TextView, "text.json")}
    end
    
    def render("text.json", %{text: text}) do
        %{
            id: text["id"],
            text: text["text"]
        }
    end
  
    def render("corpus.json", %{texts: texts}) do
      %{data: render_many(texts, TextView, "corpus_item.json")}
    end
    
    def render("corpus_item.json", %{text: text}) do
        text
    end
end