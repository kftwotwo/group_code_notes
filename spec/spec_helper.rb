ENV['RACK_ENV'] = 'test'
require('rspec')
require('pg')
require('sinatra/activerecord')
require_relative '../app'
require_relative '../models/snippet'

RSpec.configure do |config|
  config.after(:each) do
    # Project.all.each(&:destroy)
  end
end
