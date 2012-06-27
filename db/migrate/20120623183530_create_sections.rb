class CreateSections < ActiveRecord::Migration
  def change
    create_table :sections do |t|
      t.string "name"
      t.integer "position"
      t.boolean "visible", :default => false
      t.string "content_type"
      t.text "content"
      t.timestamps
      t.references :page
    end
    add_index("sections", "page_id") #always add indexes on foreign keys
  end
end
