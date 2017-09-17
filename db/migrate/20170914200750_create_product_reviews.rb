class CreateProductReviews < ActiveRecord::Migration[5.1]
  def change
    create_table :product_reviews do |t|
      t.integer :rating
      t.text :comment

      t.timestamps null: false
    end
  end
end
