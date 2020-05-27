defmodule ReshapeWeb.Router do
  use ReshapeWeb, :router

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_flash
    plug :protect_from_forgery
    plug :put_secure_browser_headers
  end

  pipeline :api do
    plug :accepts, ["json"]
  end

  # Other scopes may use custom stacks.
  scope "/api", ReshapeWeb do
    pipe_through :api

    get "/blog/post", PostController, :index

    post "/text/corpus", TextController, :get_corpus
    get "/text/generate/:language/:type", TextController, :generate
    resources "/domain", DomainController
    get "/verb/:id", VerbController, :get
    post "/flatten", FlattenController, :flatten
    post "/flatten/file", FlattenController, :flatten_from_file
    post "/flatten/traditional", FlattenController, :flatten_traditional
    post "/flatten/traditional/file", FlattenController, :flatten_traditional_from_file
    post "/csv", ConvertcsvController, :to_csv
    post "/csv/file", ConvertcsvController, :to_csv_from_file
  end
end
