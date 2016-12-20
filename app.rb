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

get '/' do
  erb :index
end
