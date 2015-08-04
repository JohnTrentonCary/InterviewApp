Rails.application.routes.draw do
  get 'search/index'
  get 'search/auth'

  root 'search#index'
end
