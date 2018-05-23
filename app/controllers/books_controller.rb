class BooksController < ApplicationController
	before_action :find_book, only: [:show, :edit, :update, :destroy]
	before_action :authenticate_account!, only: [:new, :edit]

	def index
		if params[:query] != ""
			@categories = Category.all.pluck(:name)
			if params[:advanced] == "true" or params[:all_books] != "true"
				@books = Book.text_search(params[:query]).order("created_at DESC").paginate(page: params[:page], per_page: 4)
			else
				@books = Book.all.paginate(page: params[:page], per_page: 12)
			end
			if params[:category] == "Algebra"
				@books = @books.where(["category_id = 1"])
			elsif params[:category] == "Analysis"
				@books = @books.where(["category_id = 2"])
			elsif params[:category] == "Analytic Philosophy"
				@books = @books.where(["category_id = 3"])
			elsif params[:category] == "Combinatorics"
				@books = @books.where(["category_id = 4"])
			elsif params[:category] == "Logic/Computer Science"
				@books = @books.where(["category_id = 5"])
			elsif params[:category] == "Geometry/Topology"
				@books = @books.where(["category_id = 6"])
			elsif params[:category] == "Mathematical Physics"
				@books = @books.where(["category_id = 7"])
			elsif params[:category] == "Number Theory"
				@books = @books.where(["category_id = 8"])
			end
			if params[:author] and params[:author] != ""
				@books = @books.where(["author = ?", params[:author]])
			end
		else
			flash[:notice] = "Please enter search criteria before submitting!"
			if params[:advanced] == "true"
				redirect_to books_path(:advanced => "true")
			else
				redirect_to root_path
			end
		end
	end

	def show
		if @book.reviews.blank?
			@average_review = 0
		else
			@average_review = @book.reviews.average(:rating).round(2)
		end
	end

	def new
		@book = current_account.books.build
		@categories = Category.all.map{ |c|  [c.name, c.id] }
	end

	def create
		@book = current_account.books.build(book_params)
		@book.category_id = params[:category_id]

		if @book.save
			redirect_to @book
		else
			render 'new'
		end
	end

	def edit
		@categories = Category.all.map{ |c|  [c.name, c.id] }
	end

	def update
		@categories = Category.all.map{ |c|  [c.name, c.id] }
		@book.category_id = params[:category_id]
		if @book.update(book_params)
			redirect_to book_path(@book)
		else
			render 'edit'
		end
	end

	def destroy
		@book.destroy
		redirect_to root_path
	end

	def sign_out_book
		@book = Book.find(params[:id])
		if current_account.on_hold < 3
			@book.update(tempowner_id: current_account.id)
			current_account.update(on_hold: current_account.on_hold+1)
			redirect_to request.referrer, success: "Book signed out successfully!"
		else
			redirect_to request.referrer, danger: "You cannot sign out more than 3 books at a time."
		end
	end

	def return_book
		@book = Book.find(params[:id])
		@book.update(tempowner_id: nil)
		current_account.update(on_hold: current_account.on_hold-1)
		redirect_to request.referrer
	end

	private

		def book_params
			params.require(:book).permit(:title, :description, :author, :category_id, :book_img)
		end

		def find_book
			@book = Book.find(params[:id])
		end
end
