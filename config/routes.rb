Rails.application.routes.draw do
  get 'search/index'
  get "/auth/:provider/callback" => "sessions#create"
  get '/auth/github' => "https://github.com/login/oauth/authorize?client_id=#{ENV["GITHUB_KEY"]}&scope=repo"

  root 'search#index'
end
