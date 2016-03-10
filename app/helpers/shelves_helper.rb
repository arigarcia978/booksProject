module ShelvesHelper
	def get_shelves_to_move_to(shelf)
		@shelves = Shelf.where(user_id: current_user.id) - [shelf]
	end
end
