#!/usr/bin/env ruby


#data structure used here is ruby hash
class Dict
  attr_accessor :dict, :dict_tree
  def initialize
    @dict={}
    @dict_tree={}
  end
  
  def load_from_file fn
    file = File.new(fn, "r")
    cnt = 0
    while (line = file.gets)
      elems = line.split(" ")
      word = elems[0]
      freq = elems[1]
      @dict[word]=freq

      #make the dict tree, by walking down the branch
      wordlen =  word.length
      wordindex = 0
      dc = @dict_tree
      
      while wordlen > wordindex
        char = word[wordindex]
        if dc[char].nil?
          dc[char] = {} #new branch
          dc[char]["_"]=freq
        else
          dc = dc[char] #walk the old branch
        end
        wordindex += 1
      end

      cnt += 1
    end
  end

  def match? word

  end

  def match_tree? word


  end

end


#there are some different cutting rules exisit:
# http://baike.baidu.com/view/19109.htm

class Chopper

  def initalize dict
    @dict = dict
  end

  #max match
  def chop line
    index = 0
    last  = line.length
    words=[]
    wordlen = 1
    while index<last
      word = line[index, wordlen]
      if match?(word)

      end
    end

  end

  def match? word
    ! @dict[word].nil?
  end


end

dict=Dict.new
dict.load_from_file ARGV[0]
puts dict.dict_tree
