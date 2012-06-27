class SectionEdit < ActiveRecord::Base
  # attr_accessible :title, :body
  belongs_to :editor, :class_name => "AdminUser", :foreign_key => 'admin_user_id' #same as belongs_to :admin_user
  belongs_to :section
end
