# encoding: utf-8
$mongo = true
require File.expand_path("../../../chop.rb", __FILE__)

dict=Dict.new
dict.load_from_file File.expand_path("../../../dict.txt.big", __FILE__)
