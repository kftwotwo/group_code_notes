require 'dotenv'
Dotenv.load

require 'sinatra'

require 'sinatra/activerecord'
require 'rack-flash'
require('pry')
require('gist')

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

before do
  @folders = Folder.all
end

get '/' do
  erb :index
end

post '/new_folder' do
  folder_name = params[:name]
  @folder = Folder.create(:name => folder_name)
  erb(:index)
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

# post('/new_snippet') do
#
# end
