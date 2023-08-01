class CreateReviews < ActiveRecord::Migration[7.0]
  def change
    create_table :reviews do |t|
      t.text :body, null: false
      t.references :user, null: false, foreign_key: {to_table: :users}
      t.references :restaurant, null: false, foreign_key: {to_table: :restaurants}
      t.integer :rating, null: false
      t.timestamps
    end
  end
end
