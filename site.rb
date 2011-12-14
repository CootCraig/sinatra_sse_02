require 'sinatra/base'
require './app'

class SseApp < Sinatra::Base
  get '/' do
    markdown :'../readme'
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
end

configure do
  App.start
end

