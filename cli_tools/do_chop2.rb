require './chop.rb'


dict=Dict.new
dict.load_from_file './dicts/dict.txt.big'


chop = Chopper.new dict
pp chop.chop ARGV[0]

