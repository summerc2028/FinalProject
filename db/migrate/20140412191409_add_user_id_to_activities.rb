class AddUserIdToActivities < ActiveRecord::Migration
  def change
    add_column :activities, :user_id, :integer
    add_index :activities, :user_id, unique: true
  end
end
