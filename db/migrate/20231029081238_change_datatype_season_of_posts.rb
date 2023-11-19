class ChangeDatatypeSeasonOfPosts < ActiveRecord::Migration[6.1]
  def change
    change_column :posts, :season, :integer
  end
end
