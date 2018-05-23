class AddAccountIdToBook < ActiveRecord::Migration[5.2]
  def change
    add_column :books, :account_id, :integer
  end
end
