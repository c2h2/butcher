$mongo=true
require 'sinatra'
require './chop.rb'


$dict=Dict.new
$dict.load_from_mongo 


$chop = Chopper.new $dict


get '/hi' do
  'hello'
end

get '/chop/:word' do |w|
  line = URI.unescape(w)
  res= $chop.chop line
  puts res
  res.to_s
end 

get '/reloaddb' do
  $dict.flush_wt
  $dict.load_from_mongo
  $chop= Chopper.new $dict
end
