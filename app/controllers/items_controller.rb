class ItemsController < ApplicationController
  def new
    @item = Item.new
    @organization = Organization.find(params[:organization_id])
  end

  def create
    @item = Item.new(item_params)
    @organization = Organization.find(params[:organization_id])
    if @item.save
      flash[:notice] = "Your item has been added."
      redirect_to organization_path(params[:organization_id])
    else
      flash[:errors] = @item.errors.full_messages.join(", ")
      render "new"
    end
  end

  protected

  def item_params
    params.require(:item)
      .permit(:name, :quantity, :url, :description, :status)
      .merge(organization_id: params[:organization_id])
  end
end
