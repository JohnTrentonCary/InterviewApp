require "github_search"
class SearchController < ApplicationController
  def index


    results = ::GithubSearch.search(params[:search_term], current_user.access_token) if params[:search_term] && valid_access_token?
    @items = []
    @items = results["items"] if results

    total_pages = results["total_count"]/10 if results
    total_pages += 1 if results && results['total_count']%10 != 0

    @items = Kaminari.paginate_array(@items, :total_pages => total_pages).page(params[:page]).per(10)
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
