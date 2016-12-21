helpers do
  def github_current_user_repos
    @github_current_user_repos ||= github_api_get("/users/#{current_github_username}/repos?" + hash_to_querystring('type' => 'owner',
                                                                                    'sort' => 'updated',
                                                                                    'direction' => 'desc')).map do |repo|
      repo['full_name']
    end
  end
  def get_gists
    @get_gists ||= github_api_get("/users/#{current_github_username}/gists")
  end



  def github_api_get(api_path)
    response = HTTParty.get("https://api.github.com#{api_path}",
                            headers: {"Accept" => "application/json",
                                      "Authorization" => "token #{current_github_auth_token}",
                                      "User-Agent" => "coding_notes"
                            })
    JSON.parse(response.body)
  end

  def get_gists_raw_url(gists)
    code=""
    gists.each do |gist|
      open(URI(gist.fetch('files').values[0].fetch('raw_url'))) {|f|
        f.each_line {|line|
          code+= line
          code+="<br />"
        }
      }
    end
    code
  end

  def get_gists_filenames(gists)
    code=[]
    gists.each do |gist|
      code.push(gist.fetch('files').values[0].fetch('filename'))
    end
    code
  end

  def create_new_gist(content, filename, publicness, description)
    @auth = session[:github_user][:auth_token]
    Gist.gist(content, options = {:access_token => @auth, :filename=> filename, :public => publicness, :description => description})
  end

  def import_gists()
    get_gists.each do |gist|
      content=""
      filename = gist.fetch('files').values[0].fetch('filename')
      publicness = gist.fetch('public')
      description = gist.fetch('description')
      language = gist.fetch('files').values[0].fetch('language')
      open(URI(gist.fetch('files').values[0].fetch('raw_url'))) {|f|
        f.each_line {|line|
          content+= line
          content+="<br />"
        }
      }
      Snippet.create(:title => filename, :content => content, :tags => "Github-Gist", :github_username => current_github_username, :language => language, :public => publicness)
    end
  end

end
