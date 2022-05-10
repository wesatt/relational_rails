class CreateBook < ActiveRecord::Migration[5.2]
  def change
    create_table :books do |t|
      t.string :name
      t.boolean :has_foreword
      t.integer :pages

      t.timestamps #auto creates created_at and updated_at
    end
  end
end
