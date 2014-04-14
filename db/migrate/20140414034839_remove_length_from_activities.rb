class RemoveLengthFromActivities < ActiveRecord::Migration
  def change
    remove_column :activities, :length
    add_column :activities, :length, :string
    remove_column :users, :length
  end
end
