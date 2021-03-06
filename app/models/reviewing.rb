class Reviewing < ActiveRecord::Base
  belongs_to :book
  belongs_to :user

  validates :book_id, :user_id, :rate, presence: true
  validates :rate, :numericality => { :greater_than_or_equal_to => 1, :less_than_or_equal_to => 10 }
end
