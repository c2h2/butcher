require 'sinatra'
require './chop.rb'


dict=Dict.new
dict.load_from_file './dict.txt'


$chop = Chopper.new dict
#res = chop.chop ARGV[0]


get '/hi' do
  'hello'
end

get '/chop/:word' do |w|
  line = URI.unescape(w)
  res= $chop.chop line
  puts res
  res.to_s
end 
