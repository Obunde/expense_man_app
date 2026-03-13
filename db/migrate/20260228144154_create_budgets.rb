class CreateBudgets < ActiveRecord::Migration[7.1]
  def change
    create_table :budgets do |t|
      t.integer :monthly_limit, null: false
      t.integer :month, null: false
      t.integer :year, null: false
      t.references :user, null: false, foreign_key: true

      t.timestamps
    end
    add_index :budgets, [:user_id, :month, :year], unique: true
  end
end
