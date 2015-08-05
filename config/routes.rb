Rails.application.routes.draw do
  get 'search/index'
   get "/auth/:provider/callback" => "sessions#create"
  get '/signout' => "session#destroy", :as => :signout
  get '/auth/github' => "https://github.com/login/oauth/authorize?client_id=fc2d6213e59abadd8016&scope=repo"

  root 'search#index'
end
