class CreateSubmissions < ActiveRecord::Migration[5.2]
  def change
    create_table :submissions do |t|
      t.string :title
      t.string :artist
      t.string :genre
      t.text :lyrics
      t.references :user, foreign_key: true

      t.timestamps
    end
    add_index :submissions, [:user_id, :created_at]
  end
end
