defmodule VectoraWeb.Router do
  use VectoraWeb, :router

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_live_flash
    plug :put_root_layout, html: {VectoraWeb.Layouts, :root}
    plug :protect_from_forgery
    plug :put_secure_browser_headers
  end

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/", VectoraWeb do
    pipe_through :browser
    live "/", Cursors
    # get "/", PageController, :home

    live "/gain_creators", GainCreatorLive.Index, :index
    live "/gain_creators/new", GainCreatorLive.Index, :new
    live "/gain_creators/:id/edit", GainCreatorLive.Index, :edit
    live "/gain_creators/:id", GainCreatorLive.Show, :show
    live "/gain_creators/:id/show/edit", GainCreatorLive.Show, :edit

    live "/business_model_canvas", BusinessModelCanvasLive.Index, :index
    live "/business_model_canvas/new", BusinessModelCanvasLive.Index, :new
    live "/business_model_canvas/:id/edit", BusinessModelCanvasLive.Index, :edit
    live "/business_model_canvas/:id", BusinessModelCanvasLive.Show, :show
    live "/business_model_canvas/:id/show/edit", BusinessModelCanvasLive.Show, :edit

    live "/value_propositions", ValuePropositionLive.Index, :index
    live "/value_propositions/new", ValuePropositionLive.Index, :new
    live "/value_propositions/:id/edit", ValuePropositionLive.Index, :edit
    live "/value_propositions/:id", ValuePropositionLive.Show, :show
    live "/value_propositions/:id/show/edit", ValuePropositionLive.Show, :edit

    live "/pain_killers", PainKillerLive.Index, :index
    live "/pain_killers/new", PainKillerLive.Index, :new
    live "/pain_killers/:id/edit", PainKillerLive.Index, :edit
    live "/pain_killers/:id", PainKillerLive.Show, :show
    live "/pain_killers/:id/show/edit", PainKillerLive.Show, :edit

    live "/products", ProductLive.Index, :index
    live "/products/new", ProductLive.Index, :new
    live "/products/:id/edit", ProductLive.Index, :edit
    live "/products/:id", ProductLive.Show, :show
    live "/products/:id/show/edit", ProductLive.Show, :edit

    live "/partners", PartnerLive.Index, :index
    live "/partners/new", PartnerLive.Index, :new
    live "/partners/:id/edit", PartnerLive.Index, :edit
    live "/partners/:id", PartnerLive.Show, :show
    live "/partners/:id/show/edit", PartnerLive.Show, :edit

    live "/racis", RACILive.Index, :index
    live "/racis/new", RACILive.Index, :new
    live "/racis/:id/edit", RACILive.Index, :edit
    live "/racis/:id", RACILive.Show, :show
    live "/racis/:id/show/edit", RACILive.Show, :edit

  end

  # Other scopes may use custom stacks.
  # scope "/api", VectoraWeb do
  #   pipe_through :api
  # end

  # Enable LiveDashboard and Swoosh mailbox preview in development
  if Application.compile_env(:vectora, :dev_routes) do
    # If you want to use the LiveDashboard in production, you should put
    # it behind authentication and allow only admins to access it.
    # If your application does not have an admins-only section yet,
    # you can use Plug.BasicAuth to set up some basic authentication
    # as long as you are also using SSL (which you should anyway).
    import Phoenix.LiveDashboard.Router

    scope "/dev" do
      pipe_through :browser

      live_dashboard "/dashboard", metrics: VectoraWeb.Telemetry
      forward "/mailbox", Plug.Swoosh.MailboxPreview
    end
  end
end
