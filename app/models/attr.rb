class Attr
  include Mongoid::Document
  field :name
  field :meaning

  index :name => 1
  index :meaning => 1

  validates :name, :presence => true
  validates :meaning, :presence => true
end
