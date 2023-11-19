class CreateTimeSchedules < ActiveRecord::Migration[6.1]
  def change
    create_table :time_schedules do |t|
      t.references :post, null: false, foreign_key: true
      t.time :time_stamp, null: false
      t.string :plan, null: false
      t.string :address
      t.float :latitude
      t.float :longitude

      t.timestamps
    end
  end
end
