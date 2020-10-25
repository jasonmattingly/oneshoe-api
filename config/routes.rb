Rails.application.routes.draw do
  get "secret_stuff", to: 'must_be_logged_in#secret_stuff'
  post "login", to: 'authentication#log_in'
end
