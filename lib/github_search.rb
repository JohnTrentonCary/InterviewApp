class GithubSearch
  def self.search(search)
    params = {"q" => search,
              "sort" => "star",
             "order" => "desc"}
    results = RestClient.get 'https://api.github.com/search/repositories', {:params => params}
    results = JSON.parse results
  end 
end
