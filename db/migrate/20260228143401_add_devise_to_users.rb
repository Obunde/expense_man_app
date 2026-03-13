# frozen_string_literal: true

class AddDeviseToUsers < ActiveRecord::Migration[7.1]
  def self.up
    if table_exists?(:users)
      change_table :users do |t|
        ## Database authenticatable
        t.string :email, limit: 255, null: false, default: "" unless column_exists?(:users, :email)
        t.string :encrypted_password, limit: 255, null: false, default: "" unless column_exists?(:users, :encrypted_password)

        ## Recoverable
        t.string :reset_password_token unless column_exists?(:users, :reset_password_token)
        t.datetime :reset_password_sent_at unless column_exists?(:users, :reset_password_sent_at)

        ## Rememberable
        t.datetime :remember_created_at unless column_exists?(:users, :remember_created_at)

        t.string :name, limit: 255, null: false unless column_exists?(:users, :name)
        t.boolean :admin, null: false, default: false unless column_exists?(:users, :admin)
      end
    else
      create_table :users do |t|
        ## Database authenticatable
        t.string :email, limit: 255, null: false, default: ""
        t.string :encrypted_password, limit: 255, null: false, default: ""

        ## Recoverable
        t.string :reset_password_token
        t.datetime :reset_password_sent_at

        ## Rememberable
        t.datetime :remember_created_at

        t.string :name, limit: 255, null: false
        t.boolean :admin, null: false, default: false

        t.timestamps null: false
      end
    end

    add_index :users, :email, unique: true unless index_exists?(:users, :email)
    add_index :users, :reset_password_token, unique: true unless index_exists?(:users, :reset_password_token)
    # add_index :users, :confirmation_token,   unique: true
    # add_index :users, :unlock_token,         unique: true
  end

  def self.down
    # By default, we don't want to make any assumption about how to roll back a migration when your
    # model already existed. Please edit below which fields you would like to remove in this migration.
    raise ActiveRecord::IrreversibleMigration
  end
end
