class Patient < ApplicationRecord
  has_many :patient_labs

  validates :id_number, presence: true, uniqueness: true

  accepts_nested_attributes_for :patient_labs, allow_destroy: true
end
