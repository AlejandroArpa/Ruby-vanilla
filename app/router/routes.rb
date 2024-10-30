
Router.draw do
  get "/reports", to: "reports#getAll"
  post "/reports", to: "reports#create"
  delete "/reports/:id", to: "reports#delete"
end