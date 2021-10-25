require 'gossip'

class ApplicationController < Sinatra::Base

  get '/' do
    erb :index, locals: {gossips: Gossip.all}
  end

  get '/gossips/new/' do
    erb :new_gossip
  end

  post '/gossips/new/' do
    Gossip.new(params['gossip_author'], params['gossip_content']).save
    redirect '/'
  end

  post '/' do
    gossip = Gossip.find(params['id'])
    redirect "/gossips/#{params['id']}/"
  end
  
  Gossip.all.each_with_index do |gossip, i|
    get "/gossips/#{i+1}/" do
      erb :show, locals: {id: i+1, gossip: gossip}
    end
  end
  
end