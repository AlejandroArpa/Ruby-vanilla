
Router.draw do
  get "reports", false, to: "reports#getAll" 
  get "reports", true, to: "reports#getOne"
  post "reports", to: "reports#create"
  delete "reports/:id", true, to: "reports#delete"
  put  "reports", to: "reports#edit"
end