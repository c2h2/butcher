# encoding: utf-8
start_time = Time.now
$mongo = true
db_file = "dicts/dict.txt.big"
attr_file = "dicts/words_attr.txt"

puts "Flushing old dict db."
Word.destroy_all
puts "Done flushing old db, loading dict #{db_file}, Time now = #{start_time}"
require_relative "../app/models/chop.rb"
dict=Dict.new
dict.load_from_file db_file
puts "Done, loaded dict db. Cost #{Time.now - start_time} seconds."


start_time = Time.now
puts "Done adding new words to db, adding attrs, Time now = #{start_time}"
Attr.destroy_all
attr=Attr.new
content=File.read(attr_file)
content.each_line{|d| elems=d.split(" "); a=Attr.new; a.name=elems[0]; a.meaning=elems[1]; a.save }
puts "Done, loaded attr. Cost #{Time.now - start_time} seconds."
