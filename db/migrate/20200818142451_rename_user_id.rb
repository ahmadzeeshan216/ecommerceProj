class RenameUserId < ActiveRecord::Migration[5.2]
  def change
    rename_column :products, :user_id_, :user_id
  end
end
