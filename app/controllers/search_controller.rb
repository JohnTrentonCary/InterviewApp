require "github_search"
class SearchController < ApplicationController
  helper_method :set_default
  def index

    @items = []

    results = ::GithubSearch.search(params[:search_term], current_user.access_token) if params[:search_term]
    @items = results["items"] if results
  end
end
