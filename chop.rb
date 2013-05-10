#!/usr/bin/env ruby
require 'pp'

$min_word_len = 0  #minmal match length for a word, 0 = match anything.
$mongo ||= false
$debug ||= false

require './words.rb' if $mongo

#data structure used here is ruby hash
class Dict
  attr_accessor :dict, :dict_tree
  def initialize
    @dict={}
    @dict_tree={}
  end

  def save_word_to_db word, freq, attr
    w=Word.new
    w.name = word
    w.freq = freq
    w.attr = attr
    w.save
    puts word if $debug
  end
  
  def load_from_file fn
    file = File.new(fn, "r")
    cnt = 0
    while (line = file.gets)
      elems = line.split(" ")
      word = elems[0] #first is word itself
      freq = elems[1] #2nd is freq of appearnce.
      attr = elems[2] #3rd is word attribute.
      @dict[word]=[freq, attr]
      save_word_to_db(word, freq, attr) if $mongo

      #make the dict tree, by walking down the branch
      next if word.nil?
      wordlen =  word.length
      wordindex = 0
      dc = @dict_tree
     
      
      while wordlen > wordindex
        char = word[wordindex]
        if dc[char].nil?
          dc[char] = {} #new branch
          dc[char]["_"]=[freq, attr]
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

  def mt? word #match a tree, a part of a word
    wl = word.length
    dt = @dict_tree
    
    #walk down the tree branch
    for i in 0..(wl-1)
      dt=dt[word[i]]
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
    temp_word=nil
  
    found_words=[]

    while i < line.length
      inloop = true
      while inloop
        try_word = line[i, wordlen]
  
        #try word is over the boundry of a line?
        if (i + wordlen) > line.length           
          # if so we reset wordlen and increment i. and go to next loop
          i+=1; wordlen=1
          break
        end

        if @dict.mw? try_word 
          temp_word = try_word; temp_index = i; temp_length = wordlen
          if @dict.mt? try_word
            wordlen+=1
            next
          else
            #save output
            inloop = false
            if !temp_word.nil?
              found_words << temp_word; words_index << temp_index; words_length << temp_length; temp_word = nil
              i += wordlen
            else
              #bad luck nothing found
              i += 1
            end
            wordlen = 1
            #end save output
          end
        else 
          if @dict.mt? try_word
            wordlen += 1
            next
          else
            #save output
            inloop = false
            if !temp_word.nil?
              found_words << temp_word; words_index << temp_index; words_length << temp_length; temp_word = nil
              i += temp_length
            else
              #bad luck nothing found
              i += 1
            end
            wordlen = 1
            #end save output
          end
        end

      end
      #out of a loop
    
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
