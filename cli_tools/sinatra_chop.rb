$mongo=true
require 'sinatra'
require './chop.rb'


$dict=Dict.new
$dict.load_from_mongo 


$chop = Chopper.new $dict


get '/favicon.ico' do
  ""
end

get '/' do
  'Please use /chop path.'
end

get '/chop/word/:word' do |w|
  line = URI.unescape(w)
  res= $chop.chop line
  res.to_s
end


post '/chop/line' do
  line=params[:line]
  res= $chop.chop line

  result = ""
  #result=res.map{|w| w + "|" + $dict.get_dict_word(w)[" "].map{|j| j.to_s} * "|"} * "\n"
  res.each do |w|
    result = result + w + "|" + $dict.get_dict_word(w).to_s

  end
  line + "\n"  + result
end

get '/chop/reloaddb' do
  $dict.flush_wt
  $dict.load_from_mongo
  $chop= Chopper.new $dict
end


get '/chop/form' do
  form = '<form name="input_line" action="/chop/line" method="post">
  Input <input name="line" />
  <input type="submit" value="Submit">
  </form>'
  form
end
