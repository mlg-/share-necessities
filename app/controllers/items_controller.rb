class ItemsController < ApplicationController
  before_filter :require_login
  before_filter :org_admin?

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

  def edit
    @organization = Organization.find(params[:organization_id])
    @item = Item.find(params[:item_id])
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

  def destroy
    @item = Item.find(params[:id])
    flash[:notice] = "#{@item.name.capitalize} has been deleted."
    @item.destroy
    redirect_to organization_path(params[:organization_id])
  end

  protected

  def item_params
    params.require(:item)
      .permit(:name, :quantity, :url, :description, :status)
      .merge(organization_id: params[:organization_id])
  end

  private

  def require_login
    unless user_signed_in?
      flash[:error] = "You must be signed in to do that"
      redirect_to new_user_session_path
    end
  end

  def org_admin?
    @organization = Organization.find(params[:organization_id])
    unless @organization.organizer?(current_user)
      flash[:error] = "You do not have permission to access this page."
      redirect_to organization_path(params[:organization_id])
    end
  end
end
