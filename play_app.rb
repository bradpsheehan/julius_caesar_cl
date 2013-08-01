class PlayApp < Sinatra::Base

  configure :development do
     register Sinatra::Reloader
   end

  get '/' do
    erb :index, locals: { play: Play.latest }
  end

  post '/' do
    play = Play.new(params['xml_url'])
    play.save
    redirect '/'
  end
end


