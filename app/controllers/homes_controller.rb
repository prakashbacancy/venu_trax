class HomesController < ApplicationController
  def search
    @businesses = Business.where('lower(name) LIKE ?', "%#{params[:search].downcase}%")
    @venues = Venue.where('lower(name) LIKE ?', "%#{params[:search].downcase}%")
  end
end
