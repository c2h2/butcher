#!/usr/bin/env ruby
require 'pp'


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

  def mw? word #complete match a word
    ! @dict[word].nil?
  end

  def mt? word #match a tree, more word
    wl = word.length
    dt = @dict_tree
    for i in 0..(wl-1)
      dt=dt[word[i]]
      #puts "DT: #{word}: #{dt}"
      return false if dt.nil?
    end
    return dt.size > 1
  end

end


#there are some different cutting rules exisit:
# http://baike.baidu.com/view/19109.htm

class Chopper

  def initialize dict
    @dict = dict
  end

  #find all matches and record there indexes and length.
  def chop line
    i= 0
    wordlen = 1
    words_index=[]
    words_length=[]

    found_words=[]

    while i < line.length
      inloop = true
      while inloop
        try_word = line[i, wordlen]
        if (wordlen + i) > line.length
          i+=1
          wordlen=1
          break
        end
        if @dict.mw? try_word
          if try_word.length > 1
            words_index << i
            words_length << wordlen
            #puts "#{try_word} : #{@dict.dict[try_word]}"
            found_words << try_word
          end
        end

        if @dict.mt? try_word
          wordlen +=1
        else
          inloop = false
        end
      end
      wordlen = 1
      i += 1
    end 
    
    @words_array = []
    for i in 0..(words_index.length-1)
      if @words_array[words_index[i]].nil?
        @words_array[words_index[i]]=[]
      end
      @words_array[words_index[i]] << words_length[i]
    end
    @words_array

    found_words
  end

  def reassemble_left
     

  end

  def reassemble_right

  end
  
  def reassemble_freq

  end

  def reassemble_center #via both direction

  end

end
