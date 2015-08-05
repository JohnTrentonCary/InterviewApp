require "github_search"
class SearchController < ApplicationController
  def index
    @items = []

    results = ::GithubSearch.search(params[:search_term], current_user.access_token) if params[:search_term]
    @items = results["items"] if results
  end

  def results
    
  end
end
