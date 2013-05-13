class Word
  include Mongoid::Document
  #include Mongoid::Datetime
  field :name
  field :freq, type: Integer
  field :attr
  field :is_custom, type: Boolean, default: false
  field :attr2, type: String, default: ""

  index :freq => 1

  validates :name, :presence => true
  validates :freq, :presence => true
  validates :attr, :presence => true
end
