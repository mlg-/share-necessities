class DibsController < ApplicationController
  before_action :authenticate_user!

  def new
    @dib = Dib.new
    @item = params[:item]
  end

  def create
    @item = Item.find(params[:item_id])
    @organization = @item.organization
    @dib = Dib.new(dib_params) do |dib|
      dib.user = current_user
      dib.item = @item
    end

    if @dib.quantity == nil
      flash[:error] = "Please specify a quantity."
      render "organizations/show"
    elsif @dib.quantity > @item.quantity
      flash[:notice] = %{Please specify an amount less than or
                         equal to the total needed.}
      render "organizations/show"
    else @dib.save
      @item.update(quantity: @item.quantity - @dib.quantity)
      flash[:notice] = %{Thanks so much! You can see all your promised items
                         and delivery instructions in \"My Items\" above.}
      redirect_to organization_path(id: @organization.id)
    end
  end

  def update
  end

  def index
    @dibs = Dib.where(user_id: current_user)
  end

  def destroy
    @dib = Dib.find(params[:id])
    @item = Item.find(params[:item_id])
    @dib.destroy
    organization = @item.organization
    new_total_needed = @item.quantity + @dib.quantity
    @item.update(quantity: new_total_needed)
    flash[:notice] = "This item has been removed from your list and returned
                      to #{organization.name}'s wishlist."
    redirect_to dibs_path
  end

  protected

  def dib_params
    params.require(:dib).permit(:quantity)
  end
end
