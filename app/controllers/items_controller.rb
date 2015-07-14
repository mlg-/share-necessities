class ItemsController < ApplicationController
  def new
    @item = Item.new
    @organization = Organization.find(params[:organization_id])
  end

  # def create
  #   @item = Item.new(item_params)
  #   if @item.save
  #     flash[:notice] = "Your item has been added."
  #     redirect_to organization_items_path(params[:organization_id])
  #   else
  #     flash[:errors] = @item.errors.full_messages.join(", ")
  #   end
  # end

  # protected

  # def item_params
  #   params.permit(:name, :quantity, :url, :description, :status_id)
  #   .merge(:user_id, :organization_id)
  # end
end