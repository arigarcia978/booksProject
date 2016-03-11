class AddAtributtesToBook < ActiveRecord::Migration
  def change
    add_column :books, :title, :string
    add_column :books, :image_link, :string
    add_column :books, :published_date, :string
    add_column :books, :authors, :string
    add_column :books, :description, :string
  end
end
