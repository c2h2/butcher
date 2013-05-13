# encoding: utf-8
start_time = Time.now
$mongo = true
db_file = "../../../dict.txt.big"
attr_file = "../words_attr.txt"

puts "Flush old dict db."
Word.destroy_all
puts "Done, loading dict #{db_file}, Time now = #{start_time}"

require File.expand_path("../../../chop.rb", __FILE__)
dict=Dict.new
dict.load_from_file File.expand_path(db_file, __FILE__)
puts "Done, loaded dict db. Cost #{Time.now - start_time} seconds."

Attr.destroy_all
attr=Attr.new
content=File.read(attr_file)
content.each_line{|d| elems=d.split(" "); a=Attr.new; a.name=elems[0]; a.meaning=elems[1]; a.save }
puts "Loaded attr."
