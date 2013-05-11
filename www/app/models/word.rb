class Word
  include Mongoid::Document
  #include Mongoid::Datetime
  field :name
  field :freq
  field :attr

  index :freq => 1

  validates :name, :presence => true
  validates :freq, :presence => true
  validates :attr, :presence => true
end