$mongo=true
$db_file = "config/mongoid.yml"
require 'sinatra'
require 'yaml'
require_relative 'app/models/chop.rb'


def reload_dicts
  t0 = Time.now
  puts "Plz wait for a minute, while sinatra is (re)loading dict from mongodb... Time now = #{t0}."
  $dict = Dict.new
  $dict.load_from_mongo
  $chop = Chopper.new $dict
  puts "Done loading db, elasped #{(Time.now - t0).to_i} seconds."
end


reload_dicts #get new dicts

get '/' do
  'Please use /chop path.'
end

get '/favicon.ico' do
  ""
end

get '/chop/word/:word' do |w|
  line = URI.unescape(w)
  res= $chop.chop line
  res.to_s
end

post '/chop/line' do
  line=params[:line]
  cr = $chop.chop line
  cr.to_yaml
end

get '/chop/reloaddb' do
  reload_dicts
end


get '/chop/form' do
  form = '<form name="input_line" action="/chop/line" method="post">
  Original Text: <textarea cols="150" rows="20" name="line"></textarea>
  <p></p>
  <input type="submit" value="Submit">
  </form>'
  form
end
