class CreateTableBooksShelves < ActiveRecord::Migration
  def change
    create_table :books_shelves do |t|
    	t.references :book, :null => false
    	t.references :shelf, :null => false
    end
    add_index(:books_shelves, [:book_id, :shelf_id], :unique => true)
  end
end
