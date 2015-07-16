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

  protected

  def dib_params
    params.require(:dib).permit(:quantity)
  end
end
