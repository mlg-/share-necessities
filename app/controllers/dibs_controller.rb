class DibsController < ApplicationController
  before_filter :authenticate_user!
  
  def new
    @dib = Dib.new
  end

  def create
    @dib = Dib.create(dib_params)
  end

  def update
  end

  protected

  def dib_params
    params.require(:dib).permit(:user_id, :item_id, :quantity)
  end
end