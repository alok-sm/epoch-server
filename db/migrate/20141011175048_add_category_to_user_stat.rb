class AddCategoryToUserStat < ActiveRecord::Migration
  def change
    add_column :user_stats, :category, :string
  end
end
