class Book < ActiveRecord::Base
	has_and_belongs_to_many :shelves
	has_many :reviewings

	validates :isbn, presence: true, uniqueness: true
	validates :title, presence: true
	def updateRate(id)
		@book = Book.find(id)
		@book.reviews_quantity = @book.reviewings.count
		@book.rates_total = 0

		@book.reviewings.each do |reviewing|
			@book.rates_total += reviewing.rate
		end
		
		@book.save
	end
end
