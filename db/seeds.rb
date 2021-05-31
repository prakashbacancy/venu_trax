# Creates klass for dynamic modules
Klass.find_or_create_by(name: 'Business', label: 'Business')
Klass.find_or_create_by(name: 'User', label: 'User')
Klass.find_or_create_by(name: 'Venue', label: 'Venue')

# To make existing Business fields dynamic
business_prebuid_fields = {
  'domain': 'URL',
  'name': 'Text',
  'industry': 'Picklist',
  'business_type': 'Picklist',
  'phone_no': 'Phone',
  'zip_code': 'Text',
  'address': 'Text Area',
  'city': 'Text',
  'state': 'Text',
  'no_of_employee': 'Integer',
  'annual_revenue': 'Currency',
  'description': 'Text Area HTML'
}
business_prebuid_fields.each do |k, v|
  Field.find_or_create_by(name: k, label: k, column_type: v, klass_id: Klass.business.id, custom: false, deletable: false, required: true, position: 0)
end

# To make existing User fields dynamic
user_prebuid_fields = {
  'full_name': 'Text',
  'phone_no': 'Phone'
}
user_prebuid_fields.each do |k, v|
  Field.find_or_create_by(name: k, label: k, column_type: v, klass_id: Klass.user.id, custom: false, deletable: false, required: true, position: 0)
end
