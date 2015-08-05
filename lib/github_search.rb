class GithubSearch
  def self.search(search, access_token)
    params = {"q" => search,
              "sort" => "star",
             "order" => "desc",
              "access_token" => access_token}
    results = RestClient.get 'https://api.github.com/search/repositories', {:params => params}
    results = JSON.parse results
  end 
end
