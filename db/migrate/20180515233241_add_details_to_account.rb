class AddDetailsToAccount < ActiveRecord::Migration[5.2]
  def change
    add_column :accounts, :first_name, :string
    add_column :accounts, :last_name, :string
    add_column :accounts, :about, :text
  end
end
