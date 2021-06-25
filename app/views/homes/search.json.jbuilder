json.businesses do
  json.array!(@businesses) do |business|
    json.name business.name
    json.url business_path(business)
    logo_url = business.logo.attached? ? url_for(business.logo) : asset_pack_path('media/images/sample/ic_placeholder.svg')
    json.icon logo_url
  end
end

json.venues do
  json.array!(@venues) do |venue|
    json.name venue.name
    json.url venue_path(venue)
    logo_url = venue.logo.attached? ? url_for(venue.logo) : asset_pack_path('media/images/sample/ic_placeholder.svg')
    json.icon logo_url
  end
end
