class Account < ApplicationRecord
	# Include default devise modules. Others available are:
	# :confirmable, :lockable, :timeoutable and :omniauthable
	devise :database_authenticatable, :registerable,
		:recoverable, :rememberable, :trackable, :validatable
	has_many :books
	has_many :reviews

	has_attached_file :account_img, :styles => { :account_index => "250x350>", :account_show => "325x475>" }, :default_url => ActionController::Base.helpers.asset_path("defaults/default.png")
	validates_attachment_content_type :account_img, content_type: /\Aimage\/.*\z/
end
