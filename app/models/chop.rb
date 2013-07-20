#!/usr/bin/env ruby
require 'pp'

$min_word_len = 0  #minmal match length for a word, 0 = match anything.
$mongo ||= false
$debug ||= false
$db_file ||="config/mongoid.yml"

if $mongo
  require 'mongoid'
  Mongoid.load!($db_file, :development)
  require_relative "./word.rb"
end

#data structure used here is ruby hash
class Dict
  attr_accessor :dict, :dict_tree
  def initialize
    @dict={}
    @dict_tree={}
  end

  def flush_wt
    @dict={}
    @dict_tree={}
  end

  def get_dict_word word
    @dict[word]
  end

  def save_word_to_db word, freq, attr
    w=Word.new
    w.name = word
    w.freq = freq
    w.attr = attr
    w.save
    puts word if $debug
  end

  def load_from_mongo
    Word.each do |w|
      build_tree w.name, w.freq, w.attr
    end
  end
  
  def build_tree word, freq, attr
    @dict[word]=[freq, attr]
    #make the dict tree, by walking down the branch
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
  end
  
  def load_from_file fn
    file = File.new(fn, "r")
    while (line = file.gets)
      elems = line.split(" ")
      word = elems[0] #first is word itself
      freq = elems[1] #2nd is freq of appearnce.
      attr = elems[2] #3rd is word attribute.
      next if word.nil?
      save_word_to_db(word, freq, attr) if $mongo
      build_tree(word, freq, attr)
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

  def chop line
    chop_basic line
  end

  #find all matches and record there indexes and length.
  def chop_basic line
    i= 0
    wordlen = 1
    words_index=[]
    words_length=[]
    found_words=[]
    temp_word=nil
    temp_length=0

    while i < line.length
      while i + wordlen <= line.length  #break if try_word over the boundry of a line
        try_word=line[i, wordlen]
        mt=@dict.mt? try_word
        mw=@dict.mw? try_word

        if mw #if we match a word, yes-> match tree?{yes-> wordlen++ , no -> found word}, 
          temp_word = try_word; temp_length = wordlen; temp_index=i
          if mt
          else
            #found a word, and save output
            if !temp_word.nil?
              found_words << temp_word; words_index << temp_index; words_length << temp_length; temp_word = nil
              i = i + wordlen - 1
              break
            else
              #bad luck nothing found
            end
          end
        else  # not match a word, if match a tree, yes -> 
          if mt
            #not match a word, but a tree, we inc the word length
          else
            #not a tree, not a word
            if !temp_word.nil?
              found_words << temp_word; words_index << temp_index; words_length << temp_length; temp_word = nil
              i = i + temp_length - 1
              break
            else
              #bad luck nothing found
              break #no word, no tree #orpahn char. #TODO take care orphan
            end
          end
        end #end of big if
        wordlen += 1
      end
      # if so we reset wordlen and increment i. and go to next loop
      i+=1; wordlen=1
    
      #end of a line, take care of last word if have
      if !temp_word.nil?
        found_words << temp_word; words_index << temp_index; words_length << temp_length; temp_word = nil
        break
      end
      ##
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
