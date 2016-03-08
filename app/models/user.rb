class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  	devise :database_authenticatable, :registerable,
    	   :recoverable, :rememberable, :trackable, :validatable

  	has_many :shelves
  	has_many :books, through: :shelves
  	has_many :reviewings
  	has_many :books_reviewed, through: :reviewings, source: :book

  	after_create :create_shelves


protected

  	def create_shelves
		@shelf = Shelf.create(name: 'Leídos', user_id: id)
  	end

end
