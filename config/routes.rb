Rails.application.routes.draw do
    devise_for :accounts, controllers: { registrations: "registrations" }
    resources :accounts
	resources :books do
		resources :reviews
		post 'sign_out_book', on: :member
		post 'return_book', on: :member
	end
	resources :searches
	root 'books#search'
end
