class CreatePeople < ActiveRecord::Migration[7.0]
  def change
    create_table :people do |t|
      t.string :name, null: false
      t.string :phone, null: false
      t.string :email, null: false

      t.timestamps
    end
  end
end
