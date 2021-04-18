class PatientSerializer < ActiveModel::Serializer
  attributes :id, :id_number, :first_name, :last_name, :phone_mobile, :gender, :date_of_birth

  has_many :patient_labs

  def gender
    object.gender ? 'M' : 'F'
  end
end
