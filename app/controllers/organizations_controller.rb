class OrganizationsController < ApplicationController
  def new
    @organization = Organization.new
  end

  def create
    @organization = Organization.new

    if @organization.save
      Organizer.new(user_id: current_user.id, organization_id: @organization.id, role: "owner")
    end
  end

end