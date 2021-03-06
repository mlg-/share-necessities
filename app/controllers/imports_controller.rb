class ImportsController < ApplicationController
  def new
    @import = Import.new
  end

  def create
    @import = Import.new(import_params)
    @organization = Organization.find(params[:import][:organization_id])
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
    @organization = Organization.find(@import.organization_id)
    @items = Import.wishlist(@import.url)
    @items.each do |item|
      Item.create!(name: item["name"],
                   url: item["url"],
                   quantity: item["quantity"],
                   organization_id: @organization.id)
    end
    flash[:notice] = "The items below were imported."
  end

  protected

  def import_params
    params.require(:import)
    .permit(:url, :page_html, :organization_id)
    .merge(user_id: current_user.id)
  end
end
