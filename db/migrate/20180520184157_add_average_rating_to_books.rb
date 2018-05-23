class AddAverageRatingToBooks < ActiveRecord::Migration[5.2]
  def change
    add_column :books, :average_rating, :float, default: 0
  end
end
