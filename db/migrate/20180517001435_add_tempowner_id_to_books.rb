class AddTempownerIdToBooks < ActiveRecord::Migration[5.2]
  def change
    add_column :books, :tempowner_id, :integer
  end
end
