class CreateCategories < ActiveRecord::Migration[7.1]
  def change
    create_table :categories do |t|
      t.string :name, limit: 255, null: false
      t.references :user, null: false, foreign_key: true

      t.timestamps
    end
  end
end
