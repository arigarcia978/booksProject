module ReviewingsHelper

	def user_reviewed_book(book_isbn)
		@book = Book.where(isbn: book_isbn).first
		if current_user.books_reviewed.include? @book
			return false
		else
			return true
		end
	end

	def review_by_user(reviewing_id)
		if current_user.reviewings.find(reviewing_id).nil?
			return false
		else
			return true
		end
	end

	def get_book_reviewed(book_isbn)
		@book = Book.where(isbn: book_isbn).first
		if !@book.nil?
			return @book.title
		else
			@book = GoogleBooks.search(isbn: book_isbn).first
			return @book.title
		end
	end

end
