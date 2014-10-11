class AddSubcategoryToArticle < ActiveRecord::Migration
  def change
    add_column :articles, :subcategory, :string
  end
end
