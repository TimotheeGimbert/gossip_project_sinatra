require 'gossip'

class ApplicationController < Sinatra::Base

  get '/' do
    erb :index, locals: {gossips: Gossip.all} # send array of all gossips to index page
  end

  get '/gossips/new/' do
    erb :new_gossip
  end

  post '/gossips/new/' do
    Gossip.new(params['gossip_author'], params['gossip_content']).save
    redirect '/'
  end

  post '/' do
    gossip = Gossip.find(params['id']) # selects the gossip at a given position
    redirect "/gossips/#{params['id']}/" # dynamic redirection
  end

  
  Gossip.all.each_with_index do |gossip, i|

    get "/gossips/#{i+1}/" do
      erb :show, locals: {id: i+1, gossip: gossip} # sends locals data to show page
    end

    get "/gossips/#{i+1}/edit/" do
      erb :edit, locals: {id: i+1, gossip: gossip} # sends locals data to edit page
    end

    post "/gossips/#{i+1}/edit/" do
      Gossip.update(i+1, params['gossip_author'], params['gossip_content']) # modify data of a given gossip position 
      redirect "/gossips/#{i+1}/"
    end
  end

  
  
end