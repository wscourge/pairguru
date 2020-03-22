class CreateComments < ActiveRecord::Migration[6.0]
  def change
    create_table :comments, primary_key: %i[user_id movie_id] do |t|
      t.belongs_to :user, null: false, foreign_key: :comments_users_id
      t.belongs_to :movie, null: false, foreign_key: :comments_movies_id
      t.text :content

      t.timestamps
    end
  end
end
