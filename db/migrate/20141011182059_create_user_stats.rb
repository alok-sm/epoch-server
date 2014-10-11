class CreateUserStats < ActiveRecord::Migration
  def change
    create_table :user_stats do |t|
      t.string :user_email
      t.integer :points
      t.string :category

      t.timestamps
    end
  end
end
