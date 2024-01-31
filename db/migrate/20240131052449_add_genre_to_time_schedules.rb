class AddGenreToTimeSchedules < ActiveRecord::Migration[6.1]
  def change
    add_column :time_schedules, :genre, :string
  end
end
