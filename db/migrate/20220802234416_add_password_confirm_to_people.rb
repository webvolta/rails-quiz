class AddPasswordConfirmToPeople < ActiveRecord::Migration[7.0]
  def change
    add_column :people, :password_confirm, :string
  end
end
