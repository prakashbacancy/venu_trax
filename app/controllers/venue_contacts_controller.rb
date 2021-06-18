class VenueContactsController < ApplicationController
  before_action :authenticate_user!
  before_action :find_venue, only: %i[new edit create update destroy]
  before_action :venue_contact, only: %i[show new edit create update]
  before_action :find_dynamic_fields, only: %i[new edit create update]

  def create
    check_and_update_user
  end

  def update
    update_venue_contact :Updated
  end

  def destroy
    if venue_contact.user.destroy
      flash[:success] = 'Venue Contact Successfully Deleted!'
    else
      flash[:alert] = 'Error Occurred While Deleting A Venue Contact!'
    end
    @venue_contacts = @venue.venue_contacts
  end

  private

  def venue_contact
    @venue_contact ||= if params[:id].present?
                         VenueContact.find(params[:id])
                       else
                         @venue.venue_contacts.new
                       end
  end

  def find_venue
    @venue = Venue.find(params[:venue_id])
  end

  def venue_contact_params
    dynamic_params = Klass.venue_contact.fields.pluck(:name)
    params.require(:venue_contact).permit(VenueContact::PERMITTED_PARAM + dynamic_params)
  end

  def update_venue_contact(msg)
    if venue_contact.update(venue_contact_params)
      flash[:success] = "Venue Contact Successfully #{msg}!"
      (@venue_contact_more = VenueContact.new) if params[:add_more].present?
    else
      flash[:alert] = venue_contact.errors.full_messages.join(', ')
    end
    @venue_contacts = @venue.venue_contacts
  end

  def set_reset_password_token(user)
    raw, enc = Devise.token_generator.generate(user.class, :reset_password_token)
    user.reset_password_token   = enc
    user.reset_password_sent_at = Time.now.utc
    user.save
    raw
  end

  def check_and_update_user
    user = User.create(email: venue_contact_params[:email],
                       full_name: venue_contact_params[:full_name],
                       phone_no: venue_contact_params[:phone_no],
                       contact: 1, skip_password_validation: true)
    if user.errors.any?
      flash[:alert] = user.errors.full_messages.join(', ')
    else
      params[:venue_contact][:user_id] = user.id
      update_venue_contact :Added
      link_raw = set_reset_password_token(user)
      UserMailer.new_user_password_confirmation(user, link_raw).deliver_now
    end
  end

  def find_dynamic_fields
    @klass = Klass.venue_contact
    fields = @klass.fields.includes(:field_picklist_values)
    @data = {}
    fields.each do |field|
      @data[field.name.to_sym] = field.field_picklist_values.pluck(:value)
    end
  end
end
