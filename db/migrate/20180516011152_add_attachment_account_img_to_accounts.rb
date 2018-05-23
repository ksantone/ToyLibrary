class AddAttachmentAccountImgToAccounts < ActiveRecord::Migration[5.2]
  def self.up
    change_table :accounts do |t|
      t.attachment :account_img
    end
  end

  def self.down
    remove_attachment :accounts, :account_img
  end
end
