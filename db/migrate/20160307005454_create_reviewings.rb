class CreateReviewings < ActiveRecord::Migration
  def change
    create_table :reviewings do |t|
      t.belongs_to :book, index: true, foreign_key: true
      t.belongs_to :user, index: true, foreign_key: true
      t.decimal :rate, default: 1
      t.string :review

      t.timestamps null: false	
    end
  end
end
