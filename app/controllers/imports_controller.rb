class ImportsController < ApplicationController
  def new
    @import = Import.new
  end

  def create
    @import = Import.new(import_params)
    @organization = Organization.find(params[:import][:organization_id])
    @items = Import.wishlist(@import.url)
    binding.pry
    if @import.save
      flash[:notice] = "Your wishlist is importing."
      redirect_to import_path(@import)
    else
      flash[:error] = @import.errors.full_messages.join(", ")
      redirect_to new_organization_item_path(id: @organization.id)
    end
  end

  def show
    @import = Import.find(params[:id])
  end

  protected

  def import_params
    params.require(:import)
    .permit(:url, :page_html, :organization_id)
    .merge(user_id: current_user.id)
  end
end