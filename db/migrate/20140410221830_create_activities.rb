class CreateActivities < ActiveRecord::Migration
  def change
    create_table :activities do |t|
      t.string :name
      t.date :day
      t.time :time
      t.integer :length
      t.string :location

      t.timestamps
    end
  end
end
