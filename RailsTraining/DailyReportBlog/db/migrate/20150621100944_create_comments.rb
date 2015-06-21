class CreateComments < ActiveRecord::Migration
  def change
    create_table :comments do |t|
      t.text :body
      t.integer :entry_id
      t.integer :user_id

      t.timestamps null: false
    end
    add_index :comments, [:entry_id, :created_at]
  end
end
