class ProductReviewsController < ApplicationController
   before_action :find_book
   before_action :find_product_review, only: [:edit, :update, :destroy]
   before_action :authenticate_user!, only: [:new, :edit]

    def new
      @product_review = ProductReview.new
    end

    def create
      @product_review = current_user.product_reviews.build(product_review_params)
      puts product_review_params
      @product_review.book_id = @book.id
      # @product_review.user_id = current_user.id

      if @product_review.save
        redirect_to @book
      else
        render 'new'
      end
    end

    def edit
    end

    def update
      if @product_review.update(product_review_params)
        redirect_to @book
      else
        render 'edit'
      end
    end

    def destroy
      @product_review.destroy
      redirect_to @book
    end

  private
    def product_review_params
      params.require(:product_review).permit(:rating, :comment)
    end

    def find_book
      @book = Book.find(params[:book_id])
    end

    def find_product_review
      @product_review = ProductReview.find(params[:id])
    end
end
