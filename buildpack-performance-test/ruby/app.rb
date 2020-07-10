require 'sinatra'
configure { set :server, :thin }

get '/' do
  'Hello small ruby sample!'
end