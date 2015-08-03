Rails.application.routes.draw do
  get 'search/index'
  get 'search/results'

  root 'search#index'
end
