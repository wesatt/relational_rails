class CreateAuthor < ActiveRecord::Migration[5.2]
  def change
    create_table :authors do |t|
      t.string :name
      t.boolean :still_active
      t.integer :age

      t.timestamps #auto creates created_at and updated_at
    end
  end
end
