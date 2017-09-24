class RemoveAuthorCategoryDescroption < ActiveRecord::Migration[5.1]
  def change
    remove_column :books, :author, :string
    remove_column :books, :category, :integer
    remove_column :books, :description, :text
    remove_column :books, :isbn, :string
  end
end
