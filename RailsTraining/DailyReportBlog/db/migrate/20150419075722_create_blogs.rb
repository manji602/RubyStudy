class CreateBlogs < ActiveRecord::Migration
  def change
    create_table :blogs do |t|
      t.string :title
      t.string :description
      t.datetime :created_at
      t.datetime :updated_at

      t.timestamps null: false
    end
  end
end
