class Book < ApplicationRecord
	belongs_to :account
	belongs_to :category
	has_many :reviews

	has_attached_file :book_img, :styles => { :book_index => "250x350>", :book_show => "325x475>" }, default_url: ":styles/default-book.png"
	validates_attachment_content_type :book_img, content_type: /\Aimage\/.*\z/

	include PgSearch
	pg_search_scope :search, against: [:title, :description, :author],
		using: {tsearch: {:prefix => true, dictionary: "english"}},
		associated_against: {reviews: [:comment]},
		ignoring: :accents

	def self.text_search(query)
		if query.present?
			search(query)
		else
			all
		end
	end
end
