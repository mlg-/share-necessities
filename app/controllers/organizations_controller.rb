class OrganizationsController < ApplicationController
  before_filter :authenticate_user!, only: [:new, :create, :edit, :update, :destroy]

  def index
    @organizations = Organization.all.order(:name).page params[:page]
  end

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
    @dib = Dib.new
  end

  def edit
    @organization = Organization.find(params[:id])
    @organizers = Organizer.where(organization: params[:id])
    unless @organization.organizer?(current_user)
      flash[:error] = "You do not have permission to access this page."
    end
  end

  def update
    @organization = Organization.find(params[:id])
    @organizers = Organizer.where(organization: params[:id])
    if @organization.update(organization_params)
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