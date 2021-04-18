class CreatePatientLab < ActiveRecord::Migration[6.0]
  def change
    create_table :patient_labs do |t|
      t.references :patient
      t.string :lab_number
      t.string :clinic_code
      t.datetime :date_of_test
      t.jsonb :lab_studies, default: {}
    end
  end
end
