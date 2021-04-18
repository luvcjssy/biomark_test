class ParserService
  PATIENT_FIELDS = {
    id_number: %w[id_number patient_data.id_number],
    first_name: %w[first_name patient_data.first_name patient_name],
    last_name: %w[last_name patient_data.last_name patient_name],
    phone_mobile: %w[phone_mobile patient_data.phone_mobile],
    gender: %w[gender patient_data.gender],
    date_of_birth: %w[date_of_birth patient_data.date_of_birth]
  }

  PATIENT_LAB_FIELDS = {
    date_of_test: %w[date_of_test],
    lab_number: %w[lab_number],
    clinic_code: %w[clinic_code],
    lab_studies: %w[lab_studies]
  }

  def initialize(payload)
    @payload = JSON.parse(payload.to_json, object_class: OpenStruct)
  end

  def execute
    return {message: 'Error', status_code: :method_not_allowed} unless @payload

    params = patient_builder
    patient = Patient.find_or_initialize_by(id_number: params[:id_number])
    patient.assign_attributes params
    if patient.save
      {message: 'Successfully', data: PatientSerializer.new(patient)}
    else
      {message: 'Error', data: patient.errors}
    end
  end

  private

  def patient_builder
    patient_attr = {}
    patient_labs_attr = {}

    PATIENT_FIELDS.each do |attr, map_fields|
      patient_attr[attr] = fetch_data(attr, map_fields)
    end

    PATIENT_LAB_FIELDS.each do |attr, map_fields|
      patient_labs_attr[attr] = fetch_data(attr, map_fields)
    end

    patient_attr[:patient_labs_attributes] = [patient_labs_attr]

    patient_attr
  end

  def fetch_data(attr, map_fields)
    value = ''

    map_fields.each do |field|
      value = @payload.instance_eval(field) rescue nil

      if value.present?
        if field == 'patient_name'
          pname = value.split(' ')
          value = attr.to_s == 'first_name' ? pname.first : pname.last
        end

        break
      end
    end

    case attr.to_s
    when 'gender'
      %w[m male].include?(value.downcase) ? true : false
    when 'date_of_birth'
      Date.parse(value) rescue nil
    when 'date_of_test'
      DateTime.parse(value) rescue nil
    when 'lab_studies'
      value.map(&:to_h)
    else
      value
    end
  end
end