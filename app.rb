require 'dotenv'
Dotenv.load

require 'sinatra'

require 'pg_search'

require 'sinatra/activerecord'
require 'rack-flash'
require('pry')
require('gist')
require 'open-uri'

require_relative "helpers/formatting"
require_relative "helpers/sessions"
require_relative "helpers/github"

require_relative('models/snippet')
require_relative('models/folder')
require_relative "controllers/snippet"
require_relative "controllers/authentication"


enable :sessions
# set :session_secret, ENV['SESSION_SECRET'] || 'MY_DEV_SECRET_4_SNIPPETS'

use Rack::Flash

after do
  ActiveRecord::Base.clear_active_connections!
end
$language = 'Uncategorized'

before do
  if authenticated?
    @folders = Folder.where("language = '#{$language}' AND github_username = '#{current_github_username}'")
  end
end

post '/*/import_gists' do
  create_default_folders!
  import_gists()
  redirect '/language/'+$language
end
post '/import_gists' do
  create_default_folders!
  import_gists()
  redirect '/language/'+$language
end

get '/language/:lang' do
  $language = params['lang']
  @folders = Folder.where("language = '#{$language}' AND github_username = '#{current_github_username}'")
  erb(:index)
end

get '/' do
  if authenticated?
  $language = "uncategorized"
  redirect '/language/favorites'
  else
  erb(:index)
  end
end
#
post '/new_folder' do
  folder_name = params[:name]
  @folder = Folder.create(:name => folder_name, :github_username => current_github_username, :language=>$language)
  redirect '/language/'+$language
end

get '/folder/:id' do
  @folder = Folder.find(params["id"].to_i)
  @folder_name = Folder.first.name
  erb(:folder)
end

get '/folder/:id/delete' do
  @folder = Folder.find(params["id"].to_i)
  erb(:delete_folder)
end

delete '/folder/:id/delete' do
  Folder.find(params["id"].to_i).destroy
  redirect '/language/'+$language
end

patch '/folder/:id' do
  @folders = Folder.find(params["id"].to_i)
  update_name = params['update_name']
  @folders.update({:name => update_name})
  redirect '/language/'+$language
end

post('/new_snippet') do
  snippet_title = params[:title]
  snippet_description = params[:description]
  snippet_content = params[:content]
  snippet_public = params[:public]
  snippet_save_git = params[:save_git]
  snippet_favorite = params[:add_to_fav]
  # snippet_tags = params[:tags]
  folder_id = params[:folder_id]
  new_snippet = Snippet.create(:title => snippet_title, :content => snippet_content, :github_username => current_github_username, :language=>$language,:description => snippet_description, :public => snippet_public, :favorite => snippet_favorite, :gist_save => snippet_save_git)
  @folder = Folder.find(folder_id)
  @folder.snippets.push(new_snippet)
  if snippet_save_git
    create_new_gist(snippet_content, snippet_title, snippet_public, snippet_description)
  end
  if snippet_favorite
    if Folder.find_by(:language=>"favorites") == nil
      Folder.create(:name => "Default", :github_username => current_github_username, :language=>"favorites")
      @folder2 = Folder.find_by(:language=>"favorites")
      @folder2.snippets.push(new_snippet)
    else
      @folder2 = Folder.find_by(:language=>"favorites")
      @folder2.snippets.push(new_snippet)
    end
  end
  redirect '/language/'+$language
end

get '/snippet/:id' do
  @snippet = Snippet.find(params["id"].to_i)
  erb(:snippet_info)
end

get '/snippet/:id/edit' do
  @snippet = Snippet.find(params["id"].to_i)
  erb(:snippet_info)
end

patch '/snippet/:id/edit' do
  @snippet = Snippet.find(params["id"].to_i)
  snippet_title = params['update_title']
  snippet_description = params['update_description']
  snippet_content = params['update_content']
  snippet_comments = params['update_comments']
  snippet_tags = params['update_tag']
  snippet_public = params[:public]
  snippet_save_git = params[:save_git]
  snippet_favorite = params[:add_to_fav]
  @snippet.update({:title => snippet_title, :content => snippet_content, :tags => snippet_tags, :description => snippet_description, :public => snippet_public, :favorite => snippet_favorite, :comments => snippet_comments})
  if snippet_favorite
    @folder2 = Folder.find_by(:language=>"favorites")
    if @folder2 != nil
      if @folder2.snippets.exists?(@snippet)
        p "nada"
      else
        @folder2.snippets.push(@snippet)
      end
    else
        Folder.create(:name => "Default", :github_username => current_github_username, :language=>"favorites")
    end
  end
  # if snippet_save_git
  #   Gist.gist(snippet_content, options = {:access_token => @auth,:update=> @snippet.gist_id, :filename=> snippet_title, :public => snippet_public, :description => snippet_description})
  # end
  redirect '/snippet/'+params["id"]+'/edit'
end

get '/snippet/:id/delete' do
  @snippet = Snippet.find(params["id"].to_i)
  erb(:delete)
end

delete '/snippet/:id/delete' do
  Snippet.find(params['id'].to_i).destroy
  redirect '/language/'+$language
end

# search function

get("/search/results") do
  erb(:resultPage)
end

post("/search/results") do
  @folderSearch = Folder.search_by_title(params.fetch("name"))
  @snippetSearch = Snippet.search_by_title_tags_content_description(params.fetch("name"))
  erb(:resultPage)
end
