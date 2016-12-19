require("sinatra")
require("sinatra/reloader")
require('sinatra/activerecord')
also_reload("lib/**/*.rb")
require("pg")
require_relative('models/snippet')
require_relative('models/folder')

get('/') do
  erb(:index)
end
