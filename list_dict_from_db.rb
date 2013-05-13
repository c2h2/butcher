require 'mongoid'

Mongoid.load!("www/config/mongoid.yml", :development)


$mongo = true
$debug = true

require './chop.rb'


Word.all.each do |h|
  puts "#{h.name} | #{h.freq} | #{h.attr}"
end

