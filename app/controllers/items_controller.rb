class ItemsController < ApplicationController
  def new
    @item = Item.new
    @organization = Organization.find(params[:organization_id])
  end

  def create
    @item = Item.new(item_params)
    @organization = Organization.find(params[:organization_id])
    
    unless @organization.organizer?(current_user)
      flash[:error] = "You do not have permission to access this page."
    end

    if @item.save
      flash[:notice] = "Your item has been added."
      redirect_to organization_path(params[:organization_id])
    else
      flash[:errors] = @item.errors.full_messages.join(", ")
      render "new"
    end
  end

  def edit
    @organization = Organization.find(params[:organization_id])
    @item = Item.find(params[:item_id])

    unless @organization.organizer?(current_user)
      flash[:error] = "You do not have permission to access this page."
    end
  end

  def update
    @item = Item.find(params[:id])
    if @item.update(item_params)
      flash[:notice] = "#{@item.name.capitalize} has been edited."
      redirect_to organization_path(params[:organization_id])
    else
      flash[:errors] = @item.errors.full_messages.join(", ")
      render "edit"
    end
  end

  protected

  def item_params
    params.require(:item)
      .permit(:name, :quantity, :url, :description, :status)
      .merge(organization_id: params[:organization_id])
  end
end
