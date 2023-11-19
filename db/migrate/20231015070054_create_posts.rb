class CreatePosts < ActiveRecord::Migration[6.1]
  def change
    create_table :posts do |t|
      t.references :user, null: false, foreign_key: true
      t.string :title, null: false
      t.time :start_time, null: false
      t.time :end_time, null: false
      t.string :budget, null: false
      t.string :image, null: false
      t.integer :season

      t.timestamps
    end
  end
end