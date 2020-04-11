defmodule GandalfWeb.Router do
  use GandalfWeb, :router

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
  scope "/api", GandalfWeb do
    pipe_through :api

    get "/blog/post", PostController, :index

    get "/text/generate/:language/:type", TextController, :generate
    resources "/domain", DomainController
    get "/verb/:id", VerbController, :get
    post "/flatten", FlattenController, :flatten
  end
end
