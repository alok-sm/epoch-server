class CreateSubcategories < ActiveRecord::Migration
  def change
    create_table :subcategories do |t|
      t.string :name
      t.integer :postid

      t.timestamps
    end
  end
end
