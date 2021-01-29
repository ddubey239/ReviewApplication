class CreatePosts < ActiveRecord::Migration[6.1]
  def change
    create_table :posts do |t|
      t.string :reviewable_type
      t.integer :reviewable_id
      t.references :user, null: false, foreign_key: true

      t.timestamps
    end
    add_index :posts, [:reviewable_id, :user], unique: true
  end
end
