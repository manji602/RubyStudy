class CreateBlogs < ActiveRecord::Migration
  def change
    create_table :blogs do |t|
      t.string :title
      t.string :description
      t.integer :user_id

      t.timestamps
    end
    add_index :blogs, [:user_id, :created_at]
  end
end
