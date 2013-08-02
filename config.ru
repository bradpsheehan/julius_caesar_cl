Bundler.require
require './lib/julius_caesar_cl'

require 'rack/cache'

    use Rack::Cache,
      :metastore   => 'file:/var/cache/rack/meta',
      :entitystore => 'file:/var/cache/rack/body',
      :verbose     => true

run Server
