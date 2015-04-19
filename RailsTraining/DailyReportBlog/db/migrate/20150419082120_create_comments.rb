class CreateComments < ActiveRecord::Migration
  def change
    create_table :comments do |t|
      t.integer :owner_id
      t.integer :entry_id
      t.string :body
      t.datetime :created_at

      t.timestamps null: false
    end
  end
end
