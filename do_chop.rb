require './chop.rb'


dict=Dict.new
dict.load_from_file './dict.txt'


chop = Chopper.new dict
res = chop.chop ARGV[0]

pp res
#puts (chop.chop ARGV[0]).class
