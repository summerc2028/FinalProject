class AddCaloriesToExercises < ActiveRecord::Migration
  def change
  	add_column :exercises, :Calories, :Integer
  	remove_column :exercises, :Length
  end
end
