module BooksHelper

	def get_book_rate(book_isbn)
		@book = Book.where(isbn: book_isbn).first
		if @book.nil? || @book.reviews_quantity == 0
			return 1
		else
			@result = (@book.rates_total/@book.reviews_quantity)
			return @result.to_f
		end
	end

	def book_already_in_shelf(book_isbn)
		@book = Book.where(isbn: book_isbn).first
		if @book.nil?
			return false
		else 
			@shelves.each do |shelf| 
				if shelf.books.include? @book
					return true
				end
			end
			return false
		end
	end

	def get_shelf_of_book(book_isbn)
		@book = Book.where(isbn: book_isbn).first
		@shelves.each do |shelf| 
			if shelf.books.include? @book
				return shelf.name
			end
		end
	end

end
