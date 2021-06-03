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
  'address': 'Text',
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

# To make existing Venue fields dynamic
venue_prebuild_fields = {
  'domain': 'URL',
  'name': 'Text',
  'phone_no': 'Phone',
  'zip_code': 'Text',
  'address': 'Text',
  'city': 'Text',
  'state': 'Text',
  'description': 'Text Area',
  'no_of_employee': 'Integer'
}
venue_prebuild_fields.each do |k, v|
  Field.find_or_create_by(name: k, label: k, column_type: v, klass_id: Klass.venue.id, custom: false, deletable: false, required: true, position: 0)
end

# # ===============================START===============================
# # NOTE: Run this manually once in your console after all migrations for `Dynamic Groups Fields` (Required for the first time)
# # ===================================================================
#
# Group.find_or_create_by(name: 'Business Details', label: 'Business Details', klass_id: Klass.business.id, default: true)
# Group.find_or_create_by(name: 'Business Information', label: 'Business Information', klass_id: Klass.user.id, ancestry: Group.find_by(name: 'Business Details').id.to_s, default: true)
# Klass.business.fields.update_all(group_id: Group.find_by(name: 'Business Information').id)
#
# Group.find_or_create_by(name: 'User Details', label: 'User Details', klass_id: Klass.user.id, default: true)
# Group.find_or_create_by(name: 'User Information', label: 'User Information', klass_id: Klass.user.id, ancestry: Group.find_by(name: 'User Details').id.to_s, default: true)
# Klass.user.fields.update_all(group_id: Group.find_by(name: 'User Information').id)
#
# Group.find_or_create_by(name: 'Venue Details', label: 'Venue Details', klass_id: Klass.venue.id, default: true)
# Group.find_or_create_by(name: 'Venue Information', label: 'Venue Information', klass_id: Klass.venue.id, ancestry: Group.find_by(name: 'Venue Details').id.to_s, default: true)
# Klass.venue.fields.update_all(group_id: Group.find_by(name: 'Venue Information').id)
# # ===============================END=================================

# # ===============================START===============================
# # NOTE: Run this for creating just testing brands (Not required)
# # ===================================================================
#
# Brand.create(name: 'Apple')
# Brand.create(name: 'McDonals')
# Brand.create(name: 'Microsoft')
# Brand.create(name: 'Facebook')
# # ===============================END=================================
