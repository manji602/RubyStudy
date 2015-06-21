class CreateEntries < ActiveRecord::Migration
  def change
    create_table :entries do |t|
      t.string :title
      t.text :body
      t.integer :blog_id
      t.integer :user_id

      t.timestamps null: false
    end
    add_index :entries, [:blog_id, :created_at]
  end
end
