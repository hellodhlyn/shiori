Rails.application.routes.draw do
  get "/ping", to: "ping#ping"
  post "/graphql", to: "graphql#execute"
end
