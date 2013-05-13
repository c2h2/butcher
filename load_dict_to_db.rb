require 'mongoid'

Mongoid.load!("www/config/mongoid.yml", :development)

$mongo = true
$debug = false

require './chop.rb'


dict=Dict.new
dict.load_from_file './dict.txt.big'
