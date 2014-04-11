class AddFieldsToUser < ActiveRecord::Migration
  def change
    add_column :users, :gender, :string
    add_column :users, :birthdate, :date
    add_column :users, :height, :integer
    add_column :users, :weight, :integer
    add_column :users, :status, :string
    add_column :users, :fname, :string
    add_column :users, :lname, :string
  end
end
