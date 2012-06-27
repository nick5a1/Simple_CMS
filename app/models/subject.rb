class Subject < ActiveRecord::Base
  
  attr_accessible :name, :position, :visible, :created_at
  
  has_many :pages
  
  # Don't need to validate (in most cases):
  #   id's, foreign keys, timestamps, booleans, counters
  validates_presence_of :name
  validates_length_of :name, :maximum => 255 #spaces count as characters
  
  scope :visible, where(:visible => true)
  scope :invisible, where(:visible => false)
  scope :sorted, order('subjects.position ASC')
  scope :search, lambda {|query| where(["name LIKE ?", "%#{query}%"])}

end
