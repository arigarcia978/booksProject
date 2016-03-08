class Shelf < ActiveRecord::Base
  	belongs_to :user
  	has_and_belongs_to_many :books

  	validates :name, presence: true, uniqueness: { scope: :user_id }

end
