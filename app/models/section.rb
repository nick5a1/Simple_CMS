class Section < ActiveRecord::Base
  attr_accessible :name, :position, :visible, :content_type, :content, :page_id
  belongs_to :page
  has_many :section_edits
  has_many :editors, :through => :section_edits, :class_name => "AdminUser" #reaches through the join table
  
  CONTENT_TYPES = ['text', 'HTML']
  
  validates_presence_of :name
  validates_length_of :name, :maximum => 255 #spaces count as characters
  validates_inclusion_of :content_type, :in => CONTENT_TYPES, :message => "must be one of: #{CONTENT_TYPES.join(', ')}"
  validates_presence_of :content

  scope :visible, where(:visible => true)
  scope :invisible, where(:visible => false)
  scope :sorted, order('sections.position ASC')
  
end
