# Creates klass for dynamic modules
Klass.find_or_create_by(name: 'Business', label: 'Business')
Klass.find_or_create_by(name: 'User', label: 'User')
Klass.find_or_create_by(name: 'Venue', label: 'Venue')
Klass.find_or_create_by(name: 'Event', label: 'Event')
Klass.find_or_create_by(name: 'Brand', label: 'Brand')
Klass.find_or_create_by(name: 'BrandContact', label: 'BrandContact')

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

# To make existing Event fields dynamic
event_prebuild_fields = {
  # 'title': 'Text',
  # 'start_date': 'Date',
  # 'start_time': 'Time',
  # 'end_date': 'Date',
  # 'end_time': 'Time',
  'description': 'Text Area'
}
event_prebuild_fields.each do |k, v|
  Field.find_or_create_by(name: k, label: k, column_type: v, klass_id: Klass.event.id, custom: false, deletable: false, required: true, position: 0)
end

# To make existing Brand fields dynamic
brand_prebuid_fields = {
  'domain_name': 'URL',
  'name': 'Text',
  'phone_number': 'Phone',
  'website_url': 'URL',
  'street_address': 'Text',
  'city': 'Text',
  'state': 'Text',
  'country': 'Text',
  'zip_code': 'Text',
  'no_of_employee': 'Integer',
  'brand_owner': 'Text',
  'description': 'Text Area'
}
brand_prebuid_fields.each do |k, v|
  Field.find_or_create_by(name: k, label: k, column_type: v, klass_id: Klass.brand.id, custom: false, deletable: false, required: true, position: 0)
end

# To make existing BrandContact fields dynamic
brand_contact_prebuid_fields = {
  'full_name': 'Text',
  'phone_no': 'Phone',
  'job_title': 'Text'
}
brand_contact_prebuid_fields.each do |k, v|
  Field.find_or_create_by(name: k, label: k, column_type: v, klass_id: Klass.brand_contact.id, custom: false, deletable: false, required: true, position: 0)
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
#
# Group.find_or_create_by(name: 'Event Details', label: 'Event Details', klass_id: Klass.event.id, default: true)
# Group.find_or_create_by(name: 'Event Information', label: 'Event Information', klass_id: Klass.event.id, ancestry: Group.find_by(name: 'Event Details').id.to_s, default: true)
# Klass.event.fields.update_all(group_id: Group.find_by(name: 'Event Information').id)
#
# Group.find_or_create_by(name: 'Brand Details', label: 'Brand Details', klass_id: Klass.brand.id, default: true)
# Group.find_or_create_by(name: 'Brand Information', label: 'Brand Information', klass_id: Klass.brand.id, ancestry: Group.find_by(name: 'Brand Details').id.to_s, default: true)
# Klass.brand.fields.update_all(group_id: Group.find_by(name: 'Brand Information').id)
#
# Group.find_or_create_by(name: 'Brand Contact Details', label: 'Brand Contact Details', klass_id: Klass.brand_contact.id, default: true)
# Group.find_or_create_by(name: 'Brand Contact Information', label: 'Brand Contact Information', klass_id: Klass.brand_contact.id, ancestry: Group.find_by(name: 'Brand Contact Details').id.to_s, default: true)
# Klass.brand_contact.fields.update_all(group_id: Group.find_by(name: 'Brand Contact Information').id)
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
