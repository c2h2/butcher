#encoding: utf-8
require 'mongoid'

Mongoid.load!("./mongo.yml", :production)



class Word
  include Mongoid::Document
  #include Mongoid::Datetime
  field :name
  field :freq
  field :attr
end

