class AddAccountIdToReviews < ActiveRecord::Migration[5.2]
  def change
    add_column :reviews, :account_id, :integer
  end
end
