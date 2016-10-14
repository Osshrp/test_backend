class AddPublishedAtToComments < ActiveRecord::Migration[5.0]
  def change
    add_column :comments, :published_at, :datetime
  end
end
