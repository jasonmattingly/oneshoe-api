Rails.application.routes.draw do
  get "test", to: 'test#test'
  post "login", to: 'sessions#create'
end
