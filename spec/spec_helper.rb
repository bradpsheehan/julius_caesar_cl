require 'bundler/setup'
require './lib/julius_caesar_cl'
require 'rspec'

Sinatra::Application.environment = :test
Bundler.require :default, Sinatra::Application.environment
