class AddOnHoldToAccounts < ActiveRecord::Migration[5.2]
  def change
    add_column :accounts, :on_hold, :integer, default: 0
  end
end
