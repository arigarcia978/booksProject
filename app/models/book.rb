class Book < ActiveRecord::Base
	has_and_belongs_to_many :shelves
	has_many :reviewings

	validates :isbn, presence: true, uniqueness: true

	def updateRate(id, rate)
		book = Book.find(id)
		book.reviews_quantity += 1
		book.rates_total += rate
		book.save
	end
end
