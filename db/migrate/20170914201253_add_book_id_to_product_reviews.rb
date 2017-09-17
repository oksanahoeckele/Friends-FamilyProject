class AddBookIdToProductReviews < ActiveRecord::Migration[5.1]
  def change
    add_column :product_reviews, :book_id, :integer
  end
end
