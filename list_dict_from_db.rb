
$mongo = true
$debug = true

require './chop.rb'


Word.all.each do |h|
  puts "#{h.name} | #{h.freq} | #{h.attr}"
end

