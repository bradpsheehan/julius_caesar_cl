# Capybara.register_driver :rack_test do |app|
#   Capybara::RackTest::Driver.new(app, :browser => :chrome)
# end

require './play_app'
require 'rspec'
require 'rack/test'

require 'sinatra'
Sinatra::Application.environment = :test
Bundler.require :default, Sinatra::Application.environment

Test::Unit::TestCase.send :include, Rack::Test::Methods

# Set the Sinatra environment
set :environment, :test

# Add an app method for RSpec
def app
  Sinatra::Application
end

describe '/' do
  include Rack::Test::Methods

  it 'blah' do
    get '/'
    expect(page).to have_content 'Welcome!'
  end
end
