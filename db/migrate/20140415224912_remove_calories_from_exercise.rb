class RemoveCaloriesFromExercise < ActiveRecord::Migration
  def change
    remove_column :exercises, :Calories
    add_column :exercises, :calories, :integer
  end
end
