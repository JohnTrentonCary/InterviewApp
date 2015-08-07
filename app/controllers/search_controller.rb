require "github_search"
class SearchController < ApplicationController
  def index

    @items = []

    results = ::GithubSearch.search(params[:search_term], current_user.access_token) if params[:search_term] && valid_access_token?
    @items = results["items"] if results
  end

  private
  
  def valid_access_token?
    begin
      RestClient.get "https://#{ENV['GITHUB_KEY']}:#{ENV['GITHUB_SECRET']}@api.github.com/applications/#{ENV['GITHUB_KEY']}/tokens/#{current_user.access_token}"
    rescue
      redirect_to '/auth/github'
      false
    else
      true
    end
  end
end
