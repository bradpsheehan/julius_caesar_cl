class Server < Sinatra::Base

  configure do
     set :views, "lib/julius_caesar_cl/views"
   end

  get '/' do
    erb :index, locals: { play: Play.latest.to_json }
  end

  post '/' do
    play = Play.new(params['xml_url'])
    play.save
    redirect '/'
  end
end


