class CreateEntries < ActiveRecord::Migration
  def change
    create_table :entries do |t|
      t.integer :owner_id
      t.integer :blog_id
      t.string :title
      t.string :body
      t.datetime :created_at
      t.datetime :updated_at

      t.timestamps null: false
    end
  end
end
