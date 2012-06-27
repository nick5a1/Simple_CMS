class CreatePages < ActiveRecord::Migration
  def change
    create_table :pages do |t|
      t.string "name"
      t.integer "position"
      t.boolean "visible", :default => false
      t.string "permalink"
      t.timestamps
      t.references :subject
    end
    add_index("pages", "subject_id") #always add indexes on foreign keys
    add_index("pages", "permalink")
  end
end
