class AddNumberOfReviewsAndRateToBook < ActiveRecord::Migration
  def change
  	add_column :books, :reviews_quantity, :integer, default: 0
  	add_column :books, :rates_total, :integer, default: 0
  end
end
