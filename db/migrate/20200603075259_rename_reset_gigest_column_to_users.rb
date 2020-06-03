class RenameResetGigestColumnToUsers < ActiveRecord::Migration[6.0]
  def change
        rename_column :users, :reset_gigest, :reset_digest
  end
end
