class CreatePatient < ActiveRecord::Migration[6.0]
  def change
    create_table :patients do |t|
      t.string :id_number, limit: 7, null: false
      t.string :first_name
      t.string :last_name
      t.string :phone_mobile
      t.boolean :gender
      t.date :date_of_birth
    end
  end
end
