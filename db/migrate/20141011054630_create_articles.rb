class CreateArticles < ActiveRecord::Migration
  def change
    create_table :articles do |t|
      t.string :title
      t.string :category
      t.string :photo
      t.string :code
      t.string :time

      t.timestamps
    end
  end
end
