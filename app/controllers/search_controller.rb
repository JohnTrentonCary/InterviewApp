require "github_search"
class SearchController < ApplicationController
  def index
    @items = []

    results = ::GithubSearch.search(params[:search_term]) if params[:search_term]
    @items = results["items"] if results
  end

  def results
    
  end
end
