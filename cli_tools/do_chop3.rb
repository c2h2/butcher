$mongo=true
require './chop.rb'


dict=Dict.new
dict.load_from_mongo


chop = Chopper.new dict
pp chop.chop ARGV[0]

