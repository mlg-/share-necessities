class OrganizationsController < ApplicationController
  before_filter :authenticate_user!, only: [:new, :create, :edit, :update, :destroy]

  def new
    @organization = Organization.new
  end

  def create
    @organization = Organization.new(organization_params)
    if @organization.save
      Organizer.create!(user: current_user, organization: @organization)
      flash[:notice] = "Your organization has been created."
      redirect_to organization_path(@organization)
    else
      flash[:errors] = @organization.errors.full_messages.join(", ")
      render "new"
    end
  end

  def show
    @organization = Organization.find(params[:id])
  end

  def edit
    @organization = Organization.find(params[:id])
    unless @organization.organizers.any? { |o| o.user_id == current_user.id }
      flash[:error] = "You do not have permission to access this page."
    end
  end

  def update
    @organization = Organization.new(organization_params)
    if @organization.save
      flash[:notice] = "Your organization has been updated."
      redirect_to organization_path(@organization)
    else
      flash[:errors] = @organization.errors.full_messages.join(", ")
      render "edit"
    end
  end

  protected

  def organization_params
    params.require(:organization).permit(:name,
                                         :address,
                                         :city,
                                         :state,
                                         :zip,
                                         :description,
                                         :phone,
                                         :email,
                                         :url,
                                         :display_photo,
                                         :delivery_instructions)
  end
end