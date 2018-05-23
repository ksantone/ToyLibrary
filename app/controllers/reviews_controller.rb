class ReviewsController < ApplicationController
	before_action :find_book
	before_action :find_review, only: [:edit, :update, :destroy]
	before_action :authenticate_account!, only: [:new, :edit]

	def new
		@review = Review.new
		if account_signed_in?
			if @book.account_id == current_account.id
				flash[:notice] = "You cannot review your own book!"
				redirect_to book_path(@book)
			end
		end
	end

	def create
		@review = Review.new(review_params)
		@review.book_id = @book.id
		@review.account_id = current_account.id

		if @review.save
			@book.update_attributes(:average_rating => @book.reviews.average(:rating).round(2))
			redirect_to book_path(@book)
		else
			render 'new'
		end
	end

	def edit
		@book.update_attributes(:average_rating => @book.reviews.average(:rating).round(2))
	end

	def update
		if @review.update(review_params)
			redirect_to book_path(@book)
		else
			render 'edit'
		end
	end

	def destroy
		@review.destroy
		redirect_to book_path(@book)
	end

	private

		def review_params
			params.require(:review).permit(:rating, :comment)
		end

		def find_book
			@book = Book.find(params[:book_id])
		end

		def find_review
			@review = Review.find(params[:id])
		end

end
