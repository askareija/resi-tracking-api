# frozen_string_literal: true

class AddNameToUsers < ActiveRecord::Migration[6.0]
  def change
    add_column :users, :first_name, :string, null: false
    add_column :users, :last_name, :string
    add_column :users, :date_of_birth, :date
    add_column :users, :avatar, :string
  end
end
