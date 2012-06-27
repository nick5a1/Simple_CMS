class Page < ActiveRecord::Base
  attr_accessible :name, :position, :visible, :permalink, :subject_id
  belongs_to :subject
  has_many :sections
  has_and_belongs_to_many :editors, :class_name => "AdminUser"
  
  validates_presence_of :name
  validates_length_of :name, :maximum => 255 #spaces count as characters
  validates_presence_of :permalink
  validates_length_of :permalink, :within => 3..255
  validates_uniqueness_of :permalink
    #  for unique values by subject, :scope => :subject_id

  scope :visible, where(:visible => true)
  scope :invisible, where(:visible => false)
  scope :sorted, order('pages.position ASC')
    
end
