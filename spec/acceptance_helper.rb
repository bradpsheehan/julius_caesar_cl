require File.dirname(__FILE__) + '/spec_helper'
disable :run

require 'capybara'
require 'capybara/dsl'

Capybara.app = Server

RSpec.configure do |config|
  config.include Capybara
end
