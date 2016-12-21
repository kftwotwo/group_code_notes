require 'dotenv'
Dotenv.load

require 'sinatra'

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
$language = "Ruby"

before do
  if authenticated?
    @folders = Folder.where("language = '#{$language}' AND github_username = '#{current_github_username}'")
  end
end

post '/import_gists' do
  import_gists()
  erb(:gists)
end

get '/html' do
  $language = "HTML"
  erb(:index)
end
get '/css' do
  $language = "CSS"
  erb(:index)
end
get '/javascript' do
  $language = "Javascript"
  erb(:index)
end
get '/ruby' do
  $language = "Ruby"
  erb(:index)
end
get '/favorites' do
  $language = "Favorites"
  erb(:index)
end

get '/' do
  $language = "Favorites"
  erb :index
end
post '/new_folder' do
  folder_name = params[:name]
  @folder_language = params['selected-language']
  $language = @folder_language
  @folder = Folder.create(:name => folder_name, :github_username => current_github_username, :language=> $language)

  redirect '/'
end

get '/folder/:id' do
  @folder = Folder.find(params["id"].to_i)
  @folder_name = Folder.first.name
  erb(:folder)
end

delete '/folder/:id' do
  Folder.find(params["id"].to_i).destroy
  redirect '/'
end

patch '/folder/:id' do
  @folders = Folder.find(params["id"].to_i)
  update_name = params['update_name']
  @folders.update({:name => update_name})
  redirect '/'
end

post('/new_snippet') do
  snippet_title = params[:title]
  snippet_description = params[:description]
  snippet_content = params[:content]
  snippet_tags = params[:tags]
  folder_id = params[:folder_id]
  new_snippet = Snippet.create(:title => snippet_title, :content => snippet_content, :tags => snippet_tags, :github_username => current_github_username, :language => "ruby",:description => snippet_description, :public => true)
  @folder = Folder.find(folder_id)
  @folder.snippets.push(new_snippet)
  redirect '/'
end

get '/snippet/:id' do
  @snippet = Snippet.find(params["id"].to_i)
  erb(:snippet_info)
end

get '/snippet/:id/edit' do
  @snippet = Snippet.find(params["id"].to_i)
  erb(:snippet)
end

patch '/snippet/:id/edit' do
  @snippet = Snippet.find(params["id"].to_i)
  snippet_title = params['update_title']
  snippet_description = params['update_description']
  snippet_content = params['update_content']
  snippet_tags = params['update_tag']
  @snippet.update({:title => snippet_title, :content => snippet_content, :tags => snippet_tags, :github_username => "Josh", :language => "ruby",:description => snippet_description, :public => true})
  redirect '/'
end

delete '/snippet/:id/edit' do
  Snippet.find(params['id'].to_i).destroy
  redirect '/'
end
