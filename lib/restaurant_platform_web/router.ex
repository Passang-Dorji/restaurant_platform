defmodule RestaurantPlatformWeb.Router do
  use RestaurantPlatformWeb, :router

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/api", RestaurantPlatformWeb do
    pipe_through :api
    resources "/accounts", AccountController, except: [:new, :edit]
    resources "/restaurants", RestaurantController, except: [:new, :edit]
    resources "/tables", TableController, except: [:new, :edit]
    resources "/menu_items", MenuItemController, except: [:new, :edit]
    post "/signup", AccountController, :signup
    post "/login", AccountController, :login
    resources "/sessions", SessionController, except: [:new, :edit]
    resources "/orders", OrderController, except: [:new, :edit]
    resources "/order_lists", Order_listController, except: [:new, :edit]
   end

  # Enable LiveDashboard and Swoosh mailbox preview in development
  if Application.compile_env(:restaurant_platform, :dev_routes) do
    # If you want to use the LiveDashboard in production, you should put
    # it behind authentication and allow only admins to access it.
    # If your application does not have an admins-only section yet,
    # you can use Plug.BasicAuth to set up some basic authentication
    # as long as you are also using SSL (which you should anyway).
    import Phoenix.LiveDashboard.Router

    scope "/dev" do
      pipe_through [:fetch_session, :protect_from_forgery]

      live_dashboard "/dashboard", metrics: RestaurantPlatformWeb.Telemetry
      forward "/mailbox", Plug.Swoosh.MailboxPreview
    end
  end
end
