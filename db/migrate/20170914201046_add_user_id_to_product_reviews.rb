class AddUserIdToProductReviews < ActiveRecord::Migration[5.1]
  def change
    add_column :product_reviews, :user_id, :integer
  end
end
