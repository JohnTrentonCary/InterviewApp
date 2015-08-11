require "github_search"
class SearchController < ApplicationController
  def index

    results_per_page = 20

    begin params[:search_term] 

      results = ::GithubSearch.search(params[:search_term], current_user.access_token, results_per_page, params[:page] || 1) if params[:search_term] && valid_access_token?

    rescue
      flash.now[:alert] = "Search can't be blank"
    end

    @items = []
    @items = results["items"] if results

    total_pages = results["total_count"]/results_per_page if results
    total_pages += 1 if results && results['total_count']%results_per_page > 0

    total_count = 0
    total_count = results["total_count"] if results
    total_count = [total_count, 1000].min

#    else 
#      flash.now[:alert] = "Search can't be blank"
#    end

    @items = Kaminari.paginate_array(@items, :total_count => total_count).page(params[:page]).per(results_per_page)
 
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
