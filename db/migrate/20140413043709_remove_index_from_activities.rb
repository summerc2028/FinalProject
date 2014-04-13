class RemoveIndexFromActivities < ActiveRecord::Migration
  def change
    remove_index :activities, :user_id
  end
end
