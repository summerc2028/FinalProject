class CreateFoods < ActiveRecord::Migration
  def change
    create_table :foods do |t|
      t.string :name
      t.integer :calories
      t.date :day
      t.time :time

      t.timestamps
    end
  end
end
