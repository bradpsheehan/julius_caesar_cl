require File.dirname(__FILE__) + '/spec_helper'
disable :run

require 'capybara'
require 'capybara/dsl'

Capybara.app = Server
# Capybara.default_driver = :selenium

# Capybara.register_driver :selenium do |app|
#   Capybara::Selenium::Driver.new(app, :browser => :firefox)
# end

RSpec.configure do |config|
  config.include Capybara
end
