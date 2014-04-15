class RemoveIndexFromExercisesAndFoods < ActiveRecord::Migration
  def change
    remove_index :exercises, :user_id
    remove_index :foods, :user_id
  end
end
