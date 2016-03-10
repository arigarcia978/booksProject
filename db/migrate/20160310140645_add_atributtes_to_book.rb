class AddAtributtesToBook < ActiveRecord::Migration
  def change
    add_column :books, :title, :string
    add_column :books, :img_url, :string
  end
end
