class AddFavoritesCountToPosts < ActiveRecord::Migration[6.1]
  def change
    unless column_exists?(:posts, :favorites_count)
      add_column :posts, :favorites_count, :integer, default: 0, null: false

      Post.find_each { |post| Post.reset_counters(post.id, :favorites) }
    end
  end
end
