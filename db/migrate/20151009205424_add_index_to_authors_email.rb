class AddIndexToAuthorsEmail < ActiveRecord::Migration
  def change
    add_index :authors, :email, unique: true
  end
end
