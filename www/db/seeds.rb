# encoding: utf-8
start_time = Time.now
$mongo = true

Word.destroy_all

require File.expand_path("../../../chop.rb", __FILE__)

dict=Dict.new
dict.load_from_file File.expand_path("../../../dict.txt.big", __FILE__)
puts "Take #{Time.now - start_time} seconds"