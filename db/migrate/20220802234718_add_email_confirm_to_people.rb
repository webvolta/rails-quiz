class AddEmailConfirmToPeople < ActiveRecord::Migration[7.0]
  def change
    add_column :people, :email_check, :string
  end
end
