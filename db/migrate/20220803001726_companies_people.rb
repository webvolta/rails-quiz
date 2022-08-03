class CompaniesPeople < ActiveRecord::Migration[7.0]
  def change
    create_table :companies_people, :id => false do |t|
      t.integer :compay_id
      t.integer :person_id
    end
  end
end
