class AccountsController < ApplicationController

	# This function gets a given users books (which can be filtered by category)
	def show
		@account = Account.find(params[:id])
		@books_signed_out = Book.where(:tempowner_id => @account.id)
		if params[:category].blank?
			@books = Book.where(:account_id => @account.id).order("created_at DESC")
		else
			@category_id = Category.find_by(name: params[:category]).id
			@books = Book.where(:account_id => @account.id, :category_id => @category_id).order("created_at DESC")
		end
	end

end
