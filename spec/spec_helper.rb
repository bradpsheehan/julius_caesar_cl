# Load the Sinatra app
require File.join(File.dirname(__FILE__), '..', 'play_app')

# Load the testing libraries
require 'spec'
# require 'spec/interop/test'
require 'rack/test'
Bundler.require

# Include the Rack test methods to Test::Unit
Test::Unit::TestCase.send :include, Rack::Test::Methods

# Set the Sinatra environment
set :environment, :test

# Add an app method for RSpec
def app
  Sinatra::Application
end