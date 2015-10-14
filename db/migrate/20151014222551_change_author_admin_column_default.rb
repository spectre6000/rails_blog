class ChangeAuthorAdminColumnDefault < ActiveRecord::Migration
  def change
    change_column_default :authors, :admin, false
  end
end
