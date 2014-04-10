class CreateExercises < ActiveRecord::Migration
  def change
    create_table :exercises do |t|
      t.string :name
      t.date :day
      t.time :time
      t.integer :length

      t.timestamps
    end
  end
end
