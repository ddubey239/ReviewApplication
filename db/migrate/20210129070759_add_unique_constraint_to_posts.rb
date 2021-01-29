class AddUniqueConstraintToPosts < ActiveRecord::Migration[6.1]
  def change
    add_index :posts, [:reviewable_id, :user, :reviewable_type], unique: true
  end
end
