require 'sinatra'
require './app'

class SseApp < Sinatra::Base
  set :app_file, __FILE__
  enable :static
  #set :root, File.dirname(File.expand_path(__FILE__))

  get '/' do
    markdown :'../readme'
  end

  get '/timerpage' do
    haml :timer
  end

  get '/actorpage' do
    haml :actor, :layout => false
  end

  get '/timer/:id' do
    content_type 'text/event-stream'
    response['Transfer-Encoding'] = 'chunked'
    id = params[:id]
    stream do |out|
      (1..8).each do |i|
        data = {source: 'timer', id: id, loop: i}
        out << "data: #{JSON(data)}\n\n"
        sleep 2
      end
    end
  end

  get '/actor/:id' do
    content_type 'text/event-stream'
    response['Transfer-Encoding'] = 'chunked'
    id = params[:id]
    stream do |out|
      Celluloid::Actor[:reporter].register_and_wait(id,out)
    end
  end

  get '/stylesheets/:name.css' do
    content_type 'text/css', :charset => 'utf-8'
    scss(:"stylesheets/#{params[:name]}")
  end

  configure do
    App.start
  end
end


