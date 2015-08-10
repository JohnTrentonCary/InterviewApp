class GithubSearch
  def self.search(search, access_token, results_per_page, page)
    params = {"q" => search,
              "sort" => "star",
              "order" => "desc",
              "access_token" => access_token,
              "per_page" => results_per_page,
              "page" => page}
    results = RestClient.get 'https://api.github.com/search/repositories', {:params => params}
    results = JSON.parse results
  end 
end
